class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  prepend_before_filter :reset_filter, only: [:index]
  append_before_filter :limit_trial_invitations, only: [:new, :create]
  layout 'members'
  respond_to :html, :js

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = current_wedding.invitations.send(@filter.method)
    respond_with @invitations
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = current_wedding.invitations.find(params[:id])
    respond_with @invitation
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @invitation = Invitation.new
    2.times { @invitation.guests.build }
    respond_with @invitation
  end

  # GET /invitations/1/edit
  def edit
    @invitation = current_wedding.invitations.find(params[:id])
    @invitation.guests.build
    respond_with @invitation
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = current_wedding.invitations.new(params[:invitation])

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to invitations_path(filter: session[:filter]), notice: "#{@invitation.outer_label} was added to the invitation list!" }
        format.json { render json: @invitation, status: :created, location: @invitation }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = current_wedding.invitations.find(params[:id])

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to invitations_path(filter: session[:filter]), notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = current_wedding.invitations.find(params[:id])
    @invitation.destroy
    respond_with @invitation, location: invitations_path(filter: @filter.id)
  end

  # GET /invitations/cities/:city
  def cities
    cities = current_wedding.invitations.select('DISTINCT city').where(['city LIKE ?', "#{params[:city]}%"]).map(&:city)
    render json: cities
  end

  # GET /invitations/stats
  def stats
    missing_address_count = current_wedding.invitations.missing_address.count
    invitations_rsvp_yes_count = current_wedding.invitations.rsvp_yes.count
    invitations_rsvp_no_count = current_wedding.invitations.rsvp_no.count
    invitations_rsvp_none_count = current_wedding.invitations.rsvp_none.count
    invitations_count = current_wedding.invitations.count
    guest_count = current_wedding.invitations.sum(:size)

    render json: {
      missing_address: missing_address_count,
      invitations_rsvp_yes: invitations_rsvp_yes_count, 
      invitations_rsvp_no: invitations_rsvp_no_count, 
      invitations_rsvp_none: invitations_rsvp_none_count, 
      invitations: invitations_count,
      guests: guest_count
    }
  end

  def limit_trial_invitations
    if current_wedding.at_max_trial_invitations?
      @at_max_trial_invitations = true
      flash[:warning] = 'You have reached the maximum invitations for a trial account. Please add a payment method to continue.'
      redirect_to invitations_path
    end
  end
  private :limit_trial_invitations

  def reset_filter
    if params[:filter].blank? || params[:filter] != session[:filter]
      session.delete(:filter) 
    end
  end
  hide_action :reset_filter
end
