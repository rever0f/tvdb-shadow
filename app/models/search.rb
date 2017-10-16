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
end
