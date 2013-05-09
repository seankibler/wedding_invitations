class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :message
end
