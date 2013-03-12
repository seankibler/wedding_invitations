class Guest < ActiveRecord::Base
  attr_accessible :additional_guests, :city, :name, :kids, :state, :street, :zip, :family_id, :size, :notes

  belongs_to :family

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip}"
  end
end
