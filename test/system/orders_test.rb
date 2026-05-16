require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    click_on "Checkout"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name

    select "Check",  from: "Pay type"
    fill_in "Routing number", with: "1234"
    fill_in "Account number", with: "1234123412341234"

    click_on "Place Order"

    assert_text "Thank you for your order."
    assert_current_path store_index_path
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select PayType.find(@order.pay_type_id).name, from: "Pay type"

    click_on "Place Order"
    assert_text "Order was successfully updated."
    assert_current_path store_index_path
  end

  test "should destroy Order" do
    visit order_url(@order)
    accept_confirm { click_on "Destroy this order", match: :first }

    assert_text "Order was successfully destroyed"
  end


  test "check order and delivery" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    click_on "Add to Cart", match: :first

    click_on "Checkout"

    fill_in "Name", with: "Akif Nar"
    fill_in "Address", with: "123 Golbasi"
    fill_in "Email", with: "akif@exa.org"

    select "Check", from: "Pay type"
    fill_in "Routing number", with: "1234"
    fill_in "Account number", with: "1234123412341234"

    click_button "Place Order"
    assert_text "Thank you for your order"

    perform_enqueued_jobs
    perform_enqueued_jobs


    assert_includes [ 2, 3 ], performed_jobs.size


    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first
    assert_equal "Akif Nar", order.name
    assert_equal "123 Golbasi", order.address
    assert_equal "akif@exa.org", order.email
    assert_equal "Check", order.pay_type.name
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.first
    assert_equal [ "akif@exa.org" ], mail.to
    assert_equal "Sam ruby <depot@example.com>", mail[:from].value
    assert_includes [ "Pragmatic Store Order Confirmation", "Payment process failed" ], mail.subject
  end


   test "should update shipdate and check shipment mail" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    click_on "Add to Cart", match: :first
    click_on "Checkout"
    fill_in "Name", with: "Akif Nar"
    fill_in "Address", with: "123 Golbasi"
    fill_in "Email", with: "akif@exa.org"

    select "Check", from: "Pay type"
    fill_in "Routing number", with: "1234"
    fill_in "Account number", with: "1234123412341234"

    click_button "Place Order"
    assert_text "Thank you for your order."

    perform_enqueued_jobs
    perform_enqueued_jobs

    order = Order.last
    mail = ActionMailer::Base.deliveries.last

    if performed_jobs.size == 3
      assert order.shipdate.present?
      assert_equal "Pragmatic Store Order Shipped", mail.subject
    else
      assert order.shipdate.nil?
    end
  end



end
