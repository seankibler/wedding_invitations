class WeddingsController < ApplicationController
  respond_to :html

  def new
    @wedding = current_user.weddings.build
    @wedding.build_bride
    @wedding.build_groom
  end

  def create
    @wedding = current_user.weddings.build(params[:wedding])
    @wedding.save
    respond_with @wedding, location: invitations_path
  end
end
