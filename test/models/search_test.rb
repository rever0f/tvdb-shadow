require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  

  test "get recent" do
    assert Search.new.getRecent.count 1
  end
end
