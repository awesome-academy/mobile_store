class CreateProductDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :product_details do |t|
      t.integer :size
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
