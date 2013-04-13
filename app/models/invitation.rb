class Invitation < ActiveRecord::Base
  attr_accessible :outer_label, :city, :kids, :size, :notes, :state, :street, :wedding_id, :group_id, :zip_code

  belongs_to :wedding
  has_many :guests
  belongs_to :group

  validates :zip_code, format: {with: /\d{5}(-\d{4})?/, allow_blank: true, message: I18n.translate('validations.invitations.zip_code')}

  scope :missing_address, where("street = '' OR city = ''")
  scope :three_or_more_kids, where("kids >= 3")
  scope :brides_family, where("group_id = #{Group.find_by_name('Bride').id}")
  scope :grooms_family, where("group_id = #{Group.find_by_name('Groom').id}")
  scope :friends, where("group_id = #{Group.find_by_name('Friends').id}")

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip_code}"
  end

  def outer_label
    return 'No Label' if read_attribute(:outer_label).blank? || read_attribute(:outer_label).nil?
    read_attribute(:outer_label)
  end
end
