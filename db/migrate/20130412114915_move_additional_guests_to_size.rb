class MoveAdditionalGuestsToSize < ActiveRecord::Migration
  class Invitation < ActiveRecord::Base; end

  def up
    Invitation.where('additional_guests > 0').each do |invitation|
      invitation.update_attribute(:size,  invitation.size + invitation.additional_guests)
    end
    remove_column :invitations, :additional_guests
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
