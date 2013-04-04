class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :label
      t.integer :family_id
      t.integer :wedding_id
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :kids
      t.text :notes

      t.timestamps
    end
    add_index :invitations, :wedding_id
    add_index :invitations, [:wedding_id, :family_id]
  end
end
