require 'test_helper'

class OverviewControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get overview_show_url
    assert_response :success
  end

end
