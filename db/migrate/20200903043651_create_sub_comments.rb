class CreateSubComments < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_comments do |t|
      t.integer :user_id
      t.integer :comment_id
      t.text :content

      t.timestamps
    end
  end
end
