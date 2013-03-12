class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state, :default => 'OH'
      t.string :zip
      t.integer :additional_guests, :default => 0
      t.integer :kids, :default => 0
      t.integer :family_id
    end
    add_index :guests, :family_id
    add_index :guests, :last_name
  end
end
