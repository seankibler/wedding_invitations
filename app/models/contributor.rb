class Contributor < User
  has_and_belongs_to_many :weddings
end
