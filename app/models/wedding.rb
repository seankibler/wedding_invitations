class Wedding < ActiveRecord::Base
  attr_accessible :bride_attributes, :groom_attributes, :wedding_date
  has_many :guests
  has_many :users
  has_many :families
  has_one :groom
  has_one :bride

  accepts_nested_attributes_for :bride
  accepts_nested_attributes_for :groom
end
