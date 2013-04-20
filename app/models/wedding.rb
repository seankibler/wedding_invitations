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
end
