class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type

  validates :name, :address, :email, presence: true
  validates :pay_type_id, presence: true


  validates :credit_card_number,
    length: { is: 16, message: " must be 16 digits long" },
    format: { with: /\A\d+\z/, message: "Should consist only of numbers" },
    presence: true,
    if: -> { find_pay_type("Credit card") }

  validates :expiration_date,
  format: { with: /\A[0-9][0-9]\/[0-3][0-9]\z/, message: " invalid. Example: 03/22" },
  presence: true,
  if: -> { find_pay_type("Credit card") }

  validates :routing_number,
  length: { in: 3..5, message: " can be between 3 and 5 digits long" },
  format: { with: /\A\d+\z/, message: "Should consist only of numbers" },
  presence: true,
  if: -> { find_pay_type("Check") }

  validates :account_number,
  length: { is: 16, message: " must be 16 digits long" },
  format: { with: /\A\d+\z/, message: "Should consist only of numbers" },
  presence: true,
  if: -> { find_pay_type("Check") }


  validates :po_number,
  length: { in: 5..20, message: " must be between 5 and 20 digits long" },
  presence: true,
  if: -> { find_pay_type("Purchase order") }

  def charge!(pay_type_params)
    pay_type_name = pay_type&.name
    payment_details = {}
    payment_method = nil

    case pay_type_name
    when "Check"
      payment_method = :check
      payment_details[:routing] = pay_type_params[:routing_number]
      payment_details[:account] = pay_type_params[:account_number]
    when "Credit card"
      payment_method = :credit_card_number
      month, year = pay_type_params[:expiration_date].split("/")
      payment_details[:cc_num] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when "Purchase order"
      payment_method = :po_number
      payment_details[:po_num] = pay_type_params[:po_number]
    end

    payment_result = Pago.make_payment(order_id: id,
                    payment_method: payment_method,
                    payment_details: payment_details)

    if payment_result.succeeded?
        OrderMailer.received(self).deliver_later

        transaction do
          update!(shipdate: 1.day.from_now)
          OrderMailer.shipped(self).deliver_later
        end

    else
      raise payment_result.error
    end
  end


  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def find_pay_type(type_name)
    pay_type&.name == type_name
  end
end
