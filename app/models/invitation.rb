class Invitation < ActiveRecord::Base
  attr_accessible :outer_label, :city, :kids, :label, :notes, :state, :street, :wedding_id, :group_id, :zip_code

  belongs_to :wedding
  has_many :guests
  belongs_to :group, class_name: :family, foreign_key: :family_id

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip_code}"
  end

  def outer_label
    return 'No Label' if read_attribute(:outer_label).blank?
    read_attribute(:outer_label) || 'No Label'
  end
end
