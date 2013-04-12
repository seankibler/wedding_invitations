task :migrate => :environment do
  attributes_to_migrate = [:additional_guests, :kids, :street, :city, :state, :size, :notes]
  Guest.all.each do |guest|
    invitation = Invitation.new

    attributes_to_migrate.each do |attribute|
      invitation.send("#{attribute}=", guest.send(attribute.to_sym))
    end
    invitation.zip_code = guest.zip
    invitation.outer_label = guest.invitation_label
    invitation.group_id = guest.family_id

    invitation.guests << guest
    invitation.save
  end
end
