require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    login_as_user(users(:one))
  end

  test "should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    me = users(:one)
    post login_url, params: { name: me.name, password: "helva" }
    assert_redirected_to admin_url
    assert_equal me.id, session[:user_id]
  end

  test "should fail login" do
    me = users(:one)
    post login_url, params:{ name: me.name, password: "wrong" }
    assert_redirected_to login_url
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to store_index_url
  end
end
