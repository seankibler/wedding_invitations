class RenameUserToMember < ActiveRecord::Migration
  def change
    rename_table :users, :members
  end
end
