class AddClassifyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :classify, :integer
  end
end
