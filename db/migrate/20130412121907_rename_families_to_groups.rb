class RenameFamiliesToGroups < ActiveRecord::Migration
  def change
    rename_table :families, :groups
  end
end
