class Filter
  FILTERS = [
    {:id => 0, :name => 'Select a filter', :method => :all},
    {:id => 1, :name => 'Missing Address', :method => :missing_address},
    {:id => 2, :name => 'More than 3 kids', :method => :three_or_more_kids}
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
