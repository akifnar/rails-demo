require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest

  setup do
    login_as_user(users(:one))
  end

  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select "nav a", minimum: 4
    assert_select "main ul li", 3
    assert_select "h2", "Super Roaster 1800"
    assert_select "div", /\$[,\d]+\.\d\d/
  end
end
