class CreateMembersWeddings < ActiveRecord::Migration
  def change
    create_table :members_weddings, force: true, id: false do |t|
      t.integer :member_id
      t.integer :wedding_id
    end
  end
end
