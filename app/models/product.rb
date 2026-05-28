class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  has_rich_text :rich_description

  before_destroy :ensure_not_referenced_by_any_line_item


  validates :title, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01, message: "must be greater than or equal to 0.01" }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png|webp)\z}i,
    message: "must be a URL for GIF, JPG, Webp or PNG image."
  }
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10, message: "minimum 10 characters" }

  def price_in_locale
    rate = I18n.t("currency_settings.rate", default: 1.0).to_f
    price * rate
  end

  private
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line Items present")
        throw :abort
      end
    end
end
