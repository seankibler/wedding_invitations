class CreatePaymentsTable < ActiveRecord::Migration
  def up
    create_table :payments, force: true do |t|
      t.integer :wedding_id
      t.string :stripe_customer_id
    end
    add_index :payments, :wedding_id
  end

  def down
    remove_index :payments, :wedding_id
    drop_table :payments
  end
end
