class AddSentAtToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :sent_at, :datetime
    add_index :invitations, :sent_at
  end
end
