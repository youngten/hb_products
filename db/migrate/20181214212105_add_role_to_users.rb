class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string
    add_column :products, :user_id, :integer
  end
end
