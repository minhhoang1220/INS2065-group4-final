require "test_helper"

class SwipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @swipe = swipes(:one)
  end

  test "should get index" do
    get swipes_url
    assert_response :success
  end

  test "should get new" do
    get new_swipe_url
    assert_response :success
  end

  test "should create swipe" do
    assert_difference("Swipe.count") do
      post swipes_url, params: { swipe: { SwipeTimestamp: @swipe.SwipeTimestamp, SwipeType: @swipe.SwipeType, SwipedUserID: @swipe.SwipedUserID, SwiperUserID: @swipe.SwiperUserID } }
    end

    assert_redirected_to swipe_url(Swipe.last)
  end

  test "should show swipe" do
    get swipe_url(@swipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_swipe_url(@swipe)
    assert_response :success
  end

  test "should update swipe" do
    patch swipe_url(@swipe), params: { swipe: { SwipeTimestamp: @swipe.SwipeTimestamp, SwipeType: @swipe.SwipeType, SwipedUserID: @swipe.SwipedUserID, SwiperUserID: @swipe.SwiperUserID } }
    assert_redirected_to swipe_url(@swipe)
  end

  test "should destroy swipe" do
    assert_difference("Swipe.count", -1) do
      delete swipe_url(@swipe)
    end

    assert_redirected_to swipes_url
  end
end
