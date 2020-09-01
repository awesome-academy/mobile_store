class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :product_id,foreign_key: true
      t.integer :user_id,foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
