require "application_system_test_case"

class UsertablesTest < ApplicationSystemTestCase
  setup do
    @usertable = usertables(:one)
  end

  test "visiting the index" do
    visit usertables_url
    assert_selector "h1", text: "Usertables"
  end

  test "should create usertable" do
    visit usertables_url
    click_on "New usertable"

    fill_in "Typemem", with: @usertable.TypeMem
    fill_in "Active", with: @usertable.active
    fill_in "Age", with: @usertable.age
    fill_in "Bio", with: @usertable.bio
    fill_in "Email", with: @usertable.email
    fill_in "Gender", with: @usertable.gender
    fill_in "Image", with: @usertable.image
    fill_in "Name", with: @usertable.name
    fill_in "Password", with: @usertable.password
    click_on "Create Usertable"

    assert_text "Usertable was successfully created"
    click_on "Back"
  end

  test "should update Usertable" do
    visit usertable_url(@usertable)
    click_on "Edit this usertable", match: :first

    fill_in "Typemem", with: @usertable.TypeMem
    fill_in "Active", with: @usertable.active
    fill_in "Age", with: @usertable.age
    fill_in "Bio", with: @usertable.bio
    fill_in "Email", with: @usertable.email
    fill_in "Gender", with: @usertable.gender
    fill_in "Image", with: @usertable.image
    fill_in "Name", with: @usertable.name
    fill_in "Password", with: @usertable.password
    click_on "Update Usertable"

    assert_text "Usertable was successfully updated"
    click_on "Back"
  end

  test "should destroy Usertable" do
    visit usertable_url(@usertable)
    click_on "Destroy this usertable", match: :first

    assert_text "Usertable was successfully destroyed"
  end
end
