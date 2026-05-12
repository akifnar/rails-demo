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
  length: { in: 5..20, message: " number must be between 5 and 20 digits long" },
  presence: true,
  if: -> { find_pay_type("Purchase order") }

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
