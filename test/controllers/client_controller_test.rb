require "test_helper"

class ClientControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get client_profile_url
    assert_response :success
  end
end
