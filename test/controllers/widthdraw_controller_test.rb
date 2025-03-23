require "test_helper"

class WidthdrawControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get widthdraw_index_url
    assert_response :success
  end
end
