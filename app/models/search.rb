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

  def getTvAuth
    loginData = RestClient.post(tvdbBase + '/login',
                                {"apikey": ENV['SECRET_TVDB_API_KEY'],
                                 "username": ENV['SECRET_TVDB_USER'],
                                 "userkey": ENV['SECRET_TVDB_USER_KEY']}.to_json,
                                content_type: 'application/json')
    atoken = JSON.parse(loginData)['token']

    return {Authorization: 'Bearer ' + atoken}
  end


  def getTvEndpoint(endPoint)
    begin 
      return RestClient.get(tvdbBase + endPoint, getTvAuth)
    rescue
      return {'data'=>[]}.to_json
    end
  end


  def getResults(aquery)
    results = []
    data = 'data'
    series = 'series'
    search = '/search/' + series
    querySearch = getTvEndpoint(search + '?name=' + aquery)
    rawResults = JSON.parse(querySearch)[data]

    rawResults.each do | v |
      seriesId = '/' + series + '/' + String(v['id'])
      results.append(JSON.parse(getTvEndpoint(seriesId))[data])
    end
    
    return results
    # seriesData = getTvEndpoint(seriesId)
    # JSON.parse(getTvEndpoint(seriesId))[data]
    # sdep = getTvEndpoint(seriesId + '/episodes')
    # params = getTvEndpoint(search + '/params')
  end
end
