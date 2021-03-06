class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_filter
  before_filter :set_up_wedding
  before_filter :permit_user_params, if: :devise_controller?

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
    session[:filter] ||= params[:filter]
    @filter = Filter.find(session[:filter]) 
  end
  hide_action :get_filter

  protected
  def permit_user_params
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :type
  end
end
