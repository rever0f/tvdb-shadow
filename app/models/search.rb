require 'json'
require 'rest_client'


class Search < ApplicationRecord
  validates :query, presence: true


  def getQueryCount(aquery)
    Search.where(query: aquery).count
  end
  
  def getQueryDates(aquery)
    Search.select(:created_at).where(query: aquery)
  end
  
  def getQueryHistory(aquery)
    history = { 'count' => getQueryCount(aquery) }
    history['dates'] = getQueryDates(aquery)

    return history
  end
  
  def getRecent(order='query', start=0, page=0)
    count = 'count'
    query = :query
    created = 'max(searches.created_at)'
    orders = {'created' =>  created, 'query' => query,
              count => count}
    order = orders.fetch(order, created)

    if order == count
      return Search.group(query).count.
               sort_by{ | k, v | v }.reverse
    end

    Search.select(query,'max(searches.created_at)').group(query).
      order(order)
      # order(order).limit(10).offset(start)
  end
  
  def tvdbBase
    'https://api.thetvdb.com'
  end
  
  def tvLogin
    loginData = RestClient.post(tvdbBase + '/login',
                                {"apikey": ENV['SECRET_TVDB_API_KEY'],
                                 "username": ENV['SECRET_TVDB_USER'],
                                 "userkey": ENV['SECRET_TVDB_USER_KEY']}.to_json,
                                content_type: 'application/json')
    atoken = JSON.parse(loginData)['token']
    auth=ApiAuth.where(name: 'tvdb').first
    auth.auth = atoken
    auth.save
  end

  def getTvAuth
    # ApiAuth.new.initApi('tvdb')
    if ApiAuth.where(name: 'tvdb').first.auth == ''
      tvLogin
    end

    return {Authorization: 'Bearer ' +
            ApiAuth.where(name: 'tvdb').first.auth}
  end


  def getTvEndpoint(endPoint, relogin = false)
    begin 
      if relogin then tvLogin end
      data = RestClient.get(tvdbBase + endPoint, getTvAuth)
      return JSON.parse(data)['data']
    rescue
      if relogin then return [] end
      getTvEndpoint(endPoint, true)
    end
  end


  def getResults(aquery)
    results = []
    series = 'series'
    search = '/search/' + series
    rawResults = getTvEndpoint(search + '?name=' + aquery)

    rawResults.each do | v |
      seriesId = '/' + series + '/' + String(v['id'])
      results.append(getTvEndpoint(seriesId))
      #seriesEpisodes = getTvEndpoint(seriesId + '/episodes')
    end
    
    return results
    # params = getTvEndpoint(search + '/params')
  end
end
