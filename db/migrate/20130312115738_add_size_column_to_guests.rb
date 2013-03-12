class AddSizeColumnToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :size, :integer, :default => 1
  end
end
