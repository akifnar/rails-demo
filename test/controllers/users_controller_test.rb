require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_user(users(:one))
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "Hamid", password: "gizlii", password_confirmation: "gizlii" } }
    end

    assert_redirected_to users_url
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: @user.name, password: "secret", password_confirmation: "secret" } }
    assert_redirected_to users_url
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(users(:one))
    end
    assert_redirected_to users_url
  end

  test "should login then logout" do
    get login_url
    post login_url, params: { name: "demet", password: "helva" }
    assert_redirected_to admin_url

    delete "/logout"
    assert_redirected_to store_index_url
  end
end
