class InvitationsController < ApplicationController
  before_filter :authenticate_user!
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
        format.html { redirect_to new_invitation_url, notice: "#{@invitation.name} was added to the invitation list!" }
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
        format.html { redirect_to invitations_path, notice: 'Invitation was successfully updated.' }
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
    respond_with @invitation, location: invitations_path
  end

  # GET /invitations/cities/:city
  def cities
    cities = current_wedding.invitations.select('DISTINCT city').where(['city LIKE ?', "#{params[:city]}%"]).map(&:city)
    render json: cities
  end

  # GET /invitations/stats
  def stats
    guest_count = current_wedding.invitations.sum(:size)
    kid_guest_count = current_wedding.invitations.sum(:kids)
    invitations_count = current_wedding.invitations.count
    missing_address_count = current_wedding.invitations.missing_address.count
    grooms_family_count = current_wedding.invitations.grooms_family.count
    brides_family_count = current_wedding.invitations.brides_family.count
    friends_count = current_wedding.invitations.friends.count

    render json: {
      grooms_family: grooms_family_count,
      brides_family: brides_family_count,
      friends: friends_count,
      missing_address: missing_address_count,
      invitations: invitations_count, 
      guests: guest_count, 
      kids: kid_guest_count, 
    }
  end

  def limit_trial_invitations
    if current_wedding.at_max_trial_invitations?
      @at_max_trial_invitations = true
      flash.now[:warning] = 'You have reached the maximum invitations for a trial account. Please add a payment method to continue.'
      if params[:action] == :create
        redirect_to invitations_path
      end
    end
  end
  private :limit_trial_invitations
end
