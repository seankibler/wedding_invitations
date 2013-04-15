class InvitationsController < ApplicationController
  layout 'members'
  respond_to :html, :js

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.send(@filter.method)
    respond_with @invitations
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id])
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
    @invitation = Invitation.find(params[:id])
    @invitation.guests.build
    respond_with @invitation
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])

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
    @invitation = Invitation.find(params[:id])

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
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    respond_with @invitation, location: invitations_path
  end

  def cities
    cities = Invitation.select('DISTINCT city').where(['city LIKE ?', "#{params[:city]}%"]).map(&:city)
    render json: cities
  end

  def stats
    guest_count = Invitation.sum(:size)
    kid_guest_count = Invitation.sum(:kids)
    invitations_count = Invitation.count
    missing_address_count = Invitation.missing_address.count
    grooms_family_count = Invitation.grooms_family.count
    brides_family_count = Invitation.brides_family.count
    friends_count = Invitation.friends.count

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
end
