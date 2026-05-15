class AddShipDateToOrder < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :shipdate, :datetime
  end
end
