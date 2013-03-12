class Guest < ActiveRecord::Base
  attr_accessible :additional_guests, :city, :first_name, :kids, :last_name, :state, :street, :zip, :family_id

  def self.kid_count
    Guest.all.map(&:kids).sum
  end

  def self.guests_count
    Guest.all.map(&:additional_guests).sum
  end
end
