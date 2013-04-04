class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.integer :bride_id
      t.integer :groom_id
      t.date :wedding_date

      t.timestamps
    end
  end
end
