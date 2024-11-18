require "application_system_test_case"

class SwipesTest < ApplicationSystemTestCase
  setup do
    @swipe = swipes(:one)
  end

  test "visiting the index" do
    visit swipes_url
    assert_selector "h1", text: "Swipes"
  end

  test "should create swipe" do
    visit swipes_url
    click_on "New swipe"

    fill_in "Swipetimestamp", with: @swipe.SwipeTimestamp
    fill_in "Swipetype", with: @swipe.SwipeType
    fill_in "Swipeduserid", with: @swipe.SwipedUserID
    fill_in "Swiperuserid", with: @swipe.SwiperUserID
    click_on "Create Swipe"

    assert_text "Swipe was successfully created"
    click_on "Back"
  end

  test "should update Swipe" do
    visit swipe_url(@swipe)
    click_on "Edit this swipe", match: :first

    fill_in "Swipetimestamp", with: @swipe.SwipeTimestamp
    fill_in "Swipetype", with: @swipe.SwipeType
    fill_in "Swipeduserid", with: @swipe.SwipedUserID
    fill_in "Swiperuserid", with: @swipe.SwiperUserID
    click_on "Update Swipe"

    assert_text "Swipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Swipe" do
    visit swipe_url(@swipe)
    click_on "Destroy this swipe", match: :first

    assert_text "Swipe was successfully destroyed"
  end
end
