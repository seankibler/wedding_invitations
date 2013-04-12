class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :outer_label
      t.integer :group_id
      t.integer :wedding_id
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :kids
      t.integer :size
      t.integer :additional_guests
      t.text :notes

      t.timestamps
    end
    add_index :invitations, :wedding_id
    add_index :invitations, [:wedding_id, :group_id]
  end
end
