class AddDiscountToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :discount, :integer
  end
end
