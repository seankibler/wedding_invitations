class Filter
  FILTERS = [
    { id: 0, name: 'Select a filter', method: :all},
    { id: 1, name: 'Missing Address', method: :missing_address},
    { id: 2, name: 'More than 3 kids', method: :three_or_more_kids},
    { id: 3, name: 'Brides Family', method: :brides_family},
    { id: 4, name: 'Grooms Family', method: :grooms_family},
    { id: 5, name: 'Friends', method: :friends},
    { id: 6, name: 'No Label', method: :no_label },
    { id: 7, name: 'Not Sent', method: :not_sent },
    { id: 8, name: 'Sent', method: :sent }
  ]

  attr_accessor :id, :name, :method

  def initialize(filter_attrs)
    @id = filter_attrs[:id]
    @name = filter_attrs[:name]
    @method = filter_attrs[:method]
  end

  def self.find(id)
    Filter.new(FILTERS.select {|filter_attrs| filter_attrs[:id] == id.to_i}.first)
  end

  def self.all
    FILTERS.map {|filter_attrs| Filter.new(filter_attrs) }
  end
end
