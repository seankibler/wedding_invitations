class Filter
  FILTERS = [
    { id: 9, name: 'RSVP Coming', method: :rsvp_yes},
    { id: 10, name: 'RSVP Not Coming', method: :rsvp_no},
    { id: 11, name: 'RSVP No Response', method: :rsvp_none},
    { id: 1, name: 'No Address', method: :missing_address},
    { id: 2, name: '3+ Kids', method: :three_or_more_kids},
    { id: 3, name: 'Brides Party', method: :brides_family},
    { id: 4, name: 'Grooms Party', method: :grooms_family},
    { id: 5, name: 'Mutual Friends', method: :friends},
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
    if id.nil?
      Filter.default
    else
      Filter.new(FILTERS.select {|filter_attrs| filter_attrs[:id] == id.to_i}.first)
    end
  end

  def self.all
    FILTERS.map {|filter_attrs| Filter.new(filter_attrs) }
  end

  def self.default
    new({id: 0, name: 'Default Filter', method: :all})
  end

  def default?
    @id == 0
  end
end
