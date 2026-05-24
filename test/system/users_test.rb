require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    login_as("akif","tatli")
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit users_url
    click_on "New user"

    fill_in "Name", with: "yusuf"
    fill_in "Password", with: "secret"
    fill_in "Confirm", with: "secret"
    click_on "Create User"

    assert_text "User yusuf was successfully created."
  end

  test "should update User" do
    visit user_url(@user)


    click_on "Edit this user", match: :first
    fill_in "old_password", with: "helva"
    click_on "submit"

    fill_in "Name", with: "yusuf"
    fill_in "Password", with: "secret"
    fill_in "Confirm", with: "secret"
    click_on "Update User"

    assert_text "User yusuf was successfully updated."
  end

  test "should destroy User" do
    visit user_url(@user)
    accept_confirm { click_on "Destroy this user", match: :first }

    assert_text "User was successfully destroyed."
  end
end
