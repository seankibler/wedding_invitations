class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :first_name
      t.string :last_name
      t.string :type
      t.integer :invitation_id

      t.timestamps
    end
    add_index :participants, [:invitation_id, :type]
  end
end
