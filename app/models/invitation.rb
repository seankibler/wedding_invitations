class Invitation < ActiveRecord::Base
  attr_accessible :outer_label, :city, :kids, :size, 
    :notes, :state, :street, :wedding_id, :group_id, 
    :zip_code, :guests_attributes, :sent_at

  belongs_to :wedding
  has_many :guests
  belongs_to :group

  validates :zip_code, format: {with: /\d{5}(-\d{4})?/, allow_blank: true, message: I18n.translate('validations.invitations.zip_code')}

  scope :missing_address, where("street = '' OR city = ''")
  scope :three_or_more_kids, where("kids >= 3")
  scope :brides_family, joins(:group).where(['groups.name = ?', 'Bride'])
  scope :grooms_family, joins(:group).where(['groups.name = ?', 'Groom'])
  scope :friends, joins(:group).where(['groups.name = ?', 'Friends'])
  scope :no_label, where(outer_label: nil)
  scope :not_sent, where(sent_at: nil)
  scope :sent, where(['sent_at IS NOT NULL OR sent_at != ?', ""])

  accepts_nested_attributes_for :guests, allow_destroy: true, reject_if: proc {|attributes| attributes[:name].blank?}

  def address
    "#{self.street} #{self.city}, #{self.state} #{self.zip_code}"
  end

  def outer_label
    return 'No Label' if read_attribute(:outer_label).blank? || read_attribute(:outer_label).nil?
    read_attribute(:outer_label)
  end

  def sent_at
    read_attribute(:sent_at).present?
  end

  def sent_at= boolean
    if boolean == true
      write_attribute(:sent_at, Time.now)
    else
      write_attribute(:sent_at, nil)
    end
  end
end
