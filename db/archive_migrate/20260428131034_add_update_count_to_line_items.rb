class AddUpdateCountToLineItems < ActiveRecord::Migration[7.2]
  def change
    add_column :line_items, :update_count, :integer, default: 0
  end
end
