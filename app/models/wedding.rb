class Wedding < ActiveRecord::Base
  attr_accessible :bride_attributes, :groom_attributes, :wedding_date, :groom_id, :bride_id
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
    'Sean Kibler and Ronna Mauter'
  end

  def return_address_street
    '641 Guy St. NW'
  end

  def return_address_city
    'Massillon'
  end

  def return_address_zip_code
    '44647'
  end

  def name
    groom_name = groom.present? ? groom.name : 'Handsome Groom'
    bride_name = bride.present? ? bride.name : 'Beatiful Bride'
    components << ['Joining of']
    [groom_name, bride_name].each do |participant_name|
      components << participant_name if participant_name.present?
      components << 'and'
    end
    components << "on #{wedding_date.try(:to_s, :long)}"
    return components.join(' ')
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
