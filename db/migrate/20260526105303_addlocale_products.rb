class AddlocaleProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :locale, :string, default: "en", null: false
  end
end
