class Wedding < ActiveRecord::Base
  attr_accessible :bride_attributes, :groom_attributes, :wedding_date, :groom_id, :bride_id
  has_many :guests, through: :invitations
  has_many :invitations
  has_and_belongs_to_many :members
  has_many :groups
  has_one :groom
  has_one :bride

  accepts_nested_attributes_for :bride
  accepts_nested_attributes_for :groom
end
