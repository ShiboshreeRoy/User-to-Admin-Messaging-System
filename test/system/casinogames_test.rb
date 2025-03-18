require "application_system_test_case"

class CasinogamesTest < ApplicationSystemTestCase
  setup do
    @casinogame = casinogames(:one)
  end

  test "visiting the index" do
    visit casinogames_url
    assert_selector "h1", text: "Casinogames"
  end

  test "should create casinogame" do
    visit casinogames_url
    click_on "New casinogame"

    fill_in "Description", with: @casinogame.description
    fill_in "Title", with: @casinogame.title
    fill_in "User", with: @casinogame.user_id
    click_on "Create Casinogame"

    assert_text "Casinogame was successfully created"
    click_on "Back"
  end

  test "should update Casinogame" do
    visit casinogame_url(@casinogame)
    click_on "Edit this casinogame", match: :first

    fill_in "Description", with: @casinogame.description
    fill_in "Title", with: @casinogame.title
    fill_in "User", with: @casinogame.user_id
    click_on "Update Casinogame"

    assert_text "Casinogame was successfully updated"
    click_on "Back"
  end

  test "should destroy Casinogame" do
    visit casinogame_url(@casinogame)
    click_on "Destroy this casinogame", match: :first

    assert_text "Casinogame was successfully destroyed"
  end
end
