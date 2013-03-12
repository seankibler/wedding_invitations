class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families, :force => true do |t|
      t.string :name, :unique => true
    end
  end
end
