class Invitation < ActiveRecord::Base
  attr_accessible :outer_label, :city, :kids, :label, :notes, :state, :street, :wedding_id, :group_id, :zip_code

  belongs_to :wedding
  has_many :guests
end
