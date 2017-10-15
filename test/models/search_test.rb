require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  

  test "get recent" do
    assert Search.new.getRecent('created').count 3
  end
end
