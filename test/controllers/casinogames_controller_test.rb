require "test_helper"

class CasinogamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @casinogame = casinogames(:one)
  end

  test "should get index" do
    get casinogames_url
    assert_response :success
  end

  test "should get new" do
    get new_casinogame_url
    assert_response :success
  end

  test "should create casinogame" do
    assert_difference("Casinogame.count") do
      post casinogames_url, params: { casinogame: { description: @casinogame.description, title: @casinogame.title, user_id: @casinogame.user_id } }
    end

    assert_redirected_to casinogame_url(Casinogame.last)
  end

  test "should show casinogame" do
    get casinogame_url(@casinogame)
    assert_response :success
  end

  test "should get edit" do
    get edit_casinogame_url(@casinogame)
    assert_response :success
  end

  test "should update casinogame" do
    patch casinogame_url(@casinogame), params: { casinogame: { description: @casinogame.description, title: @casinogame.title, user_id: @casinogame.user_id } }
    assert_redirected_to casinogame_url(@casinogame)
  end

  test "should destroy casinogame" do
    assert_difference("Casinogame.count", -1) do
      delete casinogame_url(@casinogame)
    end

    assert_redirected_to casinogames_url
  end
end
