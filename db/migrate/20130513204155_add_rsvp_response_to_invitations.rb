class AddRsvpResponseToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :rsvp_response, :boolean
    add_index :invitations, [:wedding_id, :rsvp_response]
  end
end
