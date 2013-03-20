class AddressLookupController < ApplicationController
  def address
    state_code = params[:state].upcase
    options = {name: params[:name], state: params[:state]}
    options.merge({state: 'OH'}) if invalid_state_code?(state_code)
    whitepages_results = WhitePages.find_person(options)
    if whitepages_results.listings.present?
      listings = whitepages_results.listings
      people = listings.map {|listing| {name: extract_listing_primary_name(listing), address: extract_listing_address(listing)} }
      render json: people
    else
      render :nothing => true
    end
  end

  def extract_listing_primary_name(listing)
    primary_person = listing.people.select{|person| person.rank == "primary"}.first
    [primary_person.firstname, primary_person.lastname].join(' ')
  end

  def extract_listing_address(listing)
    street = listing.address.fullstreet
    city = listing.address.city
    state = listing.address.state
    postal = listing.address['zip']
    "#{street} #{city}, #{state} #{postal}"
  end

  def invalid_state_code?(state_code)
    params[:state].blank? || valid_state_code?(params[:state]) == false
  end

  def valid_state_code?(state_code)
    US_STATES.include?(state_code)
  end
end
