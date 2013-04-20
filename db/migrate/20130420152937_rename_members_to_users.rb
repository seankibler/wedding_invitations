class RenameMembersToUsers < ActiveRecord::Migration
  def change
    remove_index :members, name: "index_users_on_email"
    remove_index :members, name: "index_users_on_reset_password_token" 
    rename_table :members, :users
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

    rename_table :members_weddings, :users_weddings
    rename_column :users_weddings, :member_id, :user_id
  end
end
