require "application_system_test_case"

class CartTest < ApplicationSystemTestCase
  test "revealing and hiding the cart" do
    visit store_index_url

    assert_no_selector "#cart h2"
    click_on "Add to Cart", match: :first

    assert_selector "button", text: "Empty Cart"

    click_on "Empty Cart"

    assert_no_selector "#cart h2"
  end

  test "highlighting an item when added to cart" do
    visit store_index_url

    click_on "Add to Cart", match: :first
    assert_css ".line-item-highlight"
  end
end
