require "test_helper"

class UsertablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usertable = usertables(:one)
  end

  test "should get index" do
    get usertables_url
    assert_response :success
  end

  test "should get new" do
    get new_usertable_url
    assert_response :success
  end

  test "should create usertable" do
    assert_difference("Usertable.count") do
      post usertables_url, params: { usertable: { TypeMem: @usertable.TypeMem, active: @usertable.active, age: @usertable.age, bio: @usertable.bio, email: @usertable.email, gender: @usertable.gender, image: @usertable.image, name: @usertable.name, password: @usertable.password } }
    end

    assert_redirected_to usertable_url(Usertable.last)
  end

  test "should show usertable" do
    get usertable_url(@usertable)
    assert_response :success
  end

  test "should get edit" do
    get edit_usertable_url(@usertable)
    assert_response :success
  end

  test "should update usertable" do
    patch usertable_url(@usertable), params: { usertable: { TypeMem: @usertable.TypeMem, active: @usertable.active, age: @usertable.age, bio: @usertable.bio, email: @usertable.email, gender: @usertable.gender, image: @usertable.image, name: @usertable.name, password: @usertable.password } }
    assert_redirected_to usertable_url(@usertable)
  end

  test "should destroy usertable" do
    assert_difference("Usertable.count", -1) do
      delete usertable_url(@usertable)
    end

    assert_redirected_to usertables_url
  end
end
