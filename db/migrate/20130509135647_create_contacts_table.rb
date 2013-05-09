class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts, force: true do |t|
      t.string :name
      t.string :email
      t.string :user_agent
      t.string :referrer
      t.text :message
      t.timestamps
    end
  end
end
