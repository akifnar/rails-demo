require "application_system_test_case"

class PayTypesTest < ApplicationSystemTestCase
  setup do
    @pay_type = pay_types(:one)
  end

  test "visiting the index" do
    visit pay_types_url
    assert_selector "h1", text: "Pay types"
  end

  test "should create pay type" do
    visit pay_types_url
    click_on "New pay type"

    fill_in "Id", with: @pay_type.id
    fill_in "Name", with: @pay_type.name
    click_on "Create Pay type"

    assert_text "Pay type was successfully created"
    click_on "Back"
  end

  test "should update Pay type" do
    visit pay_type_url(@pay_type)
    click_on "Edit this pay type", match: :first

    fill_in "Id", with: @pay_type.id
    fill_in "Name", with: @pay_type.name
    click_on "Update Pay type"

    assert_text "Pay type was successfully updated"
    click_on "Back"
  end

  test "should destroy Pay type" do
    visit pay_type_url(@pay_type)
    accept_confirm { click_on "Destroy this pay type", match: :first }

    assert_text "Pay type was successfully destroyed"
  end
end
