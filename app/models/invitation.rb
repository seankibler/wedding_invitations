class Invitation < ActiveRecord::Base
  attr_accessible :city, :kids, :label, :notes, :state, :street, :wedding_id, :zip_code

  belongs_to :wedding
end
