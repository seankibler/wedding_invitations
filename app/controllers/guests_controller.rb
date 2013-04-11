class GuestsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js

  # GET /guests
  # GET /guests.json
  def index
    session[:filter_id] = params[:filter_id]
    @guests = Guest.send(@filter.method)
    respond_with @guests
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id])
    respond_with @guest
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new
    respond_with @guest
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
    respond_with @guest
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])

    respond_to do |format|
      if @guest.save
        format.html { redirect_to new_guest_url, notice: "#{@guest.name} was added to the guest list!" }
        format.json { render json: @guest, status: :created, location: @guest }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find(params[:id])

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to guests_path(filter_params), notice: 'Guest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    respond_with @guest, location: guests_path(filter_params)
  end

  def cities
    cities = Guest.select('DISTINCT city').where(['city LIKE ?', "#{params[:city]}%"]).map(&:city)
    render json: cities
  end


  def stats
    guest_count = Guest.sum(:size)
    kid_guest_count = Guest.sum(:kids)
    addtl_guest_count = Guest.sum(:additional_guests)
    grand_guest_count = guest_count + kid_guest_count + addtl_guest_count
    invitations = Guest.count
    missing_address = Guest.missing_address.count
    seans_family = Guest.seans_family.count
    ronnas_family = Guest.ronnas_family.count
    friends = Guest.friends.count

    render json: {
      seans_family: seans_family,
      ronnas_family: ronnas_family,
      friends: friends,
      missing_address: missing_address,
      invitations: invitations, 
      subtotal: guest_count, 
      kids: kid_guest_count, 
      guests_of_guests: addtl_guest_count, 
      grand_total: grand_guest_count
    }
  end

  private
  def had_filter?
    session[:filter_id].present?
  end

  def filter_params
    {filter_id: session[:filter_id]} if had_filter?
  end
end
