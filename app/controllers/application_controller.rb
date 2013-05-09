class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_filter
  before_filter :set_up_wedding

  def set_up_wedding
    if user_signed_in? && current_wedding.nil? && params[:controller] != 'weddings'
      redirect_to new_wedding_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a? Admin
      admin_root_path
    else
      invitations_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.is_a? Admin
      new_admin_session_path
    else
      root_path
    end
  end

  def current_wedding
    current_user.wedding
  end
  helper_method :current_wedding

  def get_filter
    filter_id = params[:filter]
    @filter = Filter.find(filter_id) 
  end
  hide_action :get_filter
end
