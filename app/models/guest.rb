class Guest < ActiveRecord::Base
  attr_accessible :additional_guests, :city, :first_name, :kids, :last_name, :state, :street, :zip, :family_id

  belongs_to :family

  def self.kid_count
    Guest.all.map(&:kids).sum
  end

  def self.guests_count
    Guest.all.map(&:additional_guests).sum
  end

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip}"
  end
end
