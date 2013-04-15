class Participant < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :name

  def name
    if self.first_name.present? || self.last_name.present?
      [self.first_name, self.last_name].join(' ')
    end
  end

  def name=(first_last)
    first, last = first_last.split(' ')
    self.first_name = first
    self.last_name = last
  end
end
