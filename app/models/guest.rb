class Guest < ActiveRecord::Base
  attr_accessible :additional_guests, :city, :name, :kids, :state, :street, :zip, :family_id, :size

  belongs_to :family

  def self.kid_count
    Guest.all.map(&:kids).sum
  end

  def self.guests_count
    Guest.all.map(&:additional_guests).sum
  end

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip}"
  end
end
