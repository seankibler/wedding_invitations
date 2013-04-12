class Guest < ActiveRecord::Base
  attr_accessible :name, :invitation_id

  belongs_to :invitation

  validates :name, :presence => true
end
