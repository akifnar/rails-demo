class SupportRequest < ApplicationRecord
  has_many :orders
  has_rich_text :response

  def orders
    Order.where(email: self.email).order("created_at DESC").limit(2)
  end
end
