class RenamePayTypeToPayTypeIdInOrders < ActiveRecord::Migration[7.2]
  def change
    rename_column :orders, :pay_type, :pay_type_id
  end
end
