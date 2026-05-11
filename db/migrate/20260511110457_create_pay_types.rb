class CreatePayTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :pay_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
