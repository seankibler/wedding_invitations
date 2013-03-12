class AddNotesToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :notes, :text
  end
end
