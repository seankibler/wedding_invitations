class Wedding < ActiveRecord::Base
  attr_accessible :bride_attributes, :groom_attributes, :wedding_date, :groom_id, :bride_id
  has_many :guests, through: :invitations
  has_many :invitations
  has_and_belongs_to_many :users
  has_many :groups
  belongs_to :groom
  belongs_to :bride

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
    "Joining of #{groom.try(:name)} and #{bride.try(:name)} on #{wedding_date.try(:to_s, :long)}"
  end

  def at_max_trial_invitations?
    return false if paid?
    invitations.count >= MAX_TRIAL_INVITATIONS
  end

  def paid?
    FreeAccountLookup.new(bride.try(:email)).pass? 
  end
end
