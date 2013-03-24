class AddressesController < ApplicationController
  respond_to :js

  def lookup
    state_code = params[:state].upcase
    options = {name: params[:name], state: params[:state]}
    options.merge({state: 'OH'}) if invalid_state_code?(state_code)
    options[:city] = params[:city] if params[:city].present?
    options[:zip] = params[:zip] if params[:zip].present?
    whitepages_results = WhitePages.find_person(options)
    if whitepages_results.listings.present?
      listings = whitepages_results.listings
      @addresses = listings.map {|listing| 
        {
          name: listing_primary_name(listing), 
          street: listing.address.fullstreet,
          city: listing.address.city,
          state: listing.address.state,
          zip: listing.address[:zip]
        }
      }
    end
    #respond_with @addresses
    raise ActiveRecord::RecordNotFound.new 
  end

  def listing_primary_name(listing)
    primary_person = listing.people.select{|person| person.rank == "primary"}.first
    [primary_person.firstname, primary_person.lastname].join(' ')
  end

  def invalid_state_code?(state_code)
    params[:state].blank? || valid_state_code?(params[:state]) == false
  end

  def valid_state_code?(state_code)
    US_STATES.include?(state_code)
  end
end
