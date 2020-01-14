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
      @wedding.wedding_date = wedding_params[:wedding_date]
    else
      @wedding = current_user.build_wedding wedding_params
    end
    @wedding.save
    respond_with @wedding, location: invitations_path
  end

  private

  def wedding_params
    user_attrs = [:first_name, :last_name, :email, :password, :password_confirmation]
    params[:wedding].permit(:wedding_date, :groom_id, :bride_id,
                            :bride_attributes => user_attributes,
                            :groom_attributes => user_attributes)
  end
end
