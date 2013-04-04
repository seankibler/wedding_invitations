class Guest < ActiveRecord::Base
  attr_accessible :invitation_label, :additional_guests, :city, :name, :kids, :state, :street, :zip, :family_id, :size, :notes

  belongs_to :family

  scope :missing_address, where("street = '' OR city = ''")
  scope :three_or_more_kids, where("kids >= 3")
  scope :ronnas_family, where("family_id = #{Family.find_by_name('Ronna').id}")
  scope :seans_family, where("family_id = #{Family.find_by_name('Sean').id}")
  scope :friends, where("family_id = #{Family.find_by_name('Friends').id}")

  validates :name, :presence => true
  validates :zip, format: {with: /\d{5}(-\d{4})?/, allow_blank: true, message: I18n.translate('validations.guests.zip')}

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip}"
  end
end
