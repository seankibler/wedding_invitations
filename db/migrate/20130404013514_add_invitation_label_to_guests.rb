class AddInvitationLabelToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :invitation_label, :string
  end
end
