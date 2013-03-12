class GuestNames < ActiveRecord::Migration
  def change
    remove_column :guests, :first_name
    remove_column :guests, :last_name
    add_column :guests, :name, :string
    add_index :guests, :name
  end
end
