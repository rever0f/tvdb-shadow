class ApiAuth < ApplicationRecord
  def initApi(name)
    if ApiAuth.where(name: name).count != 0 then return end
    ApiAuth.new(name: name, auth: '').save
  end
end
