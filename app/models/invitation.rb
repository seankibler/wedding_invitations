class Invitation < ActiveRecord::Base
  attr_accessible :city, :family_id, :kids, :label, :notes, :state, :street, :wedding_id, :zip_code
end
