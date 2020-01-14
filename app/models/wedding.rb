class Wedding < ActiveRecord::Base
  has_one :payment
  has_many :guests, through: :invitations
  has_many :invitations
  has_and_belongs_to_many :users
  has_many :groups
  belongs_to :groom
  belongs_to :bride

  validate :wedding_date_in_future

  accepts_nested_attributes_for :bride
  accepts_nested_attributes_for :groom

  def return_address_from
    'First Last and First Last'
  end

  def return_address_street
    '123 Street Address'
  end

  def return_address_city
    'City'
  end

  def return_address_zip_code
    'Zip'
  end

  def name
    if groom.present?
      sprintf "Joining of %s and %s on %s", groom_name, bride_name, wedding_date.try(:to_s, :long)
    else
      sprintf "Joining of %s and %s on %s", bride_name, groom_name, wedding_date.try(:to_s, :long)
    end
  end

  def groom_name
    groom.present? ? groom.name : 'her handsome groom'
  end

  def bride_name
    bride.present? ? bride.name : 'his beatiful bride'
  end

  def at_max_trial_invitations?
    return false if paid?
    invitations.count >= MAX_TRIAL_INVITATIONS
  end

  def paid?
    FreeAccountLookup.new(bride.try(:email)).pass? 
  end

  private
  def wedding_date_in_future
    return true if self.persisted?
    if self.wedding_date.nil? || self.wedding_date < Date.today
      self.errors.add(:wedding_date, 'must be in the future')
      return false
    end
  end
end
