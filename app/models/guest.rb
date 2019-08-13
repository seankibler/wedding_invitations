class Guest < ActiveRecord::Base
  attr_accessible :name, :invitation_id

  belongs_to :invitation

  validates :name, :presence => true

  scope :rsvp_yes, -> { joins(:invitation).where(['invitations.rsvp_response = ?', true]) }
  scope :rsvp_no, -> { joins(:invitation).where(['invitations.rsvp_response = ?', false]) }
  scope :rsvp_none, -> { joins(:invitation).where('invitations.rsvp_response IS NULL')  }
end
