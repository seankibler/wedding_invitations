class Invitation < ActiveRecord::Base
  attr_accessible :outer_label, :city, :kids, :label, :notes, :state, :street, :wedding_id, :group_id, :zip_code

  belongs_to :wedding
  has_many :guests
  belongs_to :group, class_name: :family, foreign_key: :family_id

  validates :zip, format: {with: /\d{5}(-\d{4})?/, allow_blank: true, message: I18n.translate('validations.invitations.zip')}

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip_code}"
  end

  def outer_label
    return 'No Label' if read_attribute(:outer_label).blank? || read_attribute(:outer_label).nil?
    read_attribute(:outer_label)
  end
end
