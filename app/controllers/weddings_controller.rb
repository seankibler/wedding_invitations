class WeddingsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

  def new
    @wedding = current_user.build_wedding
    if current_user.is_a? Bride
      @wedding.build_groom
    else
      @wedding.build_bride
    end
  end

  def create
    if params[:skip_bride] || params[:skip_groom] 
      @wedding = current_user.build_wedding
      @wedding.wedding_date = params[:wedding][:wedding_date]
    else
      @wedding = current_user.build_wedding params[:wedding]
    end
    @wedding.save
    respond_with @wedding, location: invitations_path
  end
end
