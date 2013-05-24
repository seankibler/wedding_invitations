class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :message
  
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
end
