class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :phone
      t.datetime :date
      t.float :total_parts
      t.boolean :active
      t.integer :status, default: 0
      t.references :user
      t.decimal :total_amount

      t.timestamps
    end
  end
end
