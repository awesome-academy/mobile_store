class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id,foreign_key: true
      t.integer :total_price
      t.integer :order_status

      t.timestamps
    end
  end
end
