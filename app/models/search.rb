class Search < ApplicationRecord
  validates :query, presence: true


  def getQueryCount(aquery)
    Search.where(query: aquery).count
  end
  
  def getRecent(order='query', start=0)
    count = 'count'
    query = :query
    created = 'max(searches.created_at)'
    orders = {'created' =>  created, 'query' => query,
              count => count}
    order = orders.fetch(order, created)

    # return order

    if order == count
      order = created
      counts = Search.group(query).count
      counts = counts.sort_by{ | k, v | v }.reverse
    end

    Search.select(query,'max(searches.created_at)').group(query).
      order(order).limit(10).offset(start)
  end
end
