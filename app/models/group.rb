class Group < ActiveRecord::Base
  has_many :guests
  has_many :invitations
end
