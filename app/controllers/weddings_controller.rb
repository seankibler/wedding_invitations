class WeddingsController < ApplicationController
  respond_to :html

  def new
    @wedding = current_user.build_wedding
    if current_user.is_a? Bride
      @wedding.build_groom
    else
      @wedding.build_bride
    end
  end

  def create
    @wedding = current_user.build_wedding params[:wedding]
    @wedding.save
    respond_with @wedding, location: invitations_path
  end
end
