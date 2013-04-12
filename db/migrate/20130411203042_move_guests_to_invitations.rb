class MoveGuestsToInvitations < ActiveRecord::Migration

  class Guest < ActiveRecord::Base
    belongs_to :invitation
  end
  class Invitation < ActiveRecord::Base
    has_many :guests
  end

  def up
    add_column :guests, :invitation_id, :integer
    add_index :guests, :invitation_id

    Guest.reset_column_information

    attributes_to_migrate = [:additional_guests, :kids, :street, :city, :state, :size, :notes]
    Guest.all.each do |guest|
      print "Moving guest attributes to invitation..."
      invitation = Invitation.new

      attributes_to_migrate.each do |attribute|
        invitation.send("#{attribute}=".to_sym, guest.send(attribute.to_sym))
      end
      invitation.zip_code = guest.zip
      invitation.outer_label = guest.invitation_label
      invitation.group_id = guest.family_id

      invitation.guests << guest
      if invitation.save
        print "OK\n"
      else
        print "FAILED\n"
      end
    end

    remove_column :guests, :invitation_label
    remove_column :guests, :family_id
    remove_column :guests, :additional_guests
    remove_column :guests, :kids
    remove_column :guests, :street
    remove_column :guests, :city
    remove_column :guests, :state
    remove_column :guests, :zip
    remove_column :guests, :size
    remove_column :guests, :notes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
