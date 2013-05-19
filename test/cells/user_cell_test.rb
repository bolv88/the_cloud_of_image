require 'test_helper'

class UserCellTest < Cell::TestCase
  test "menu" do
    invoke :menu
    assert_select "p"
  end
  

end
