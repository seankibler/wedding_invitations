class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_filter
  before_filter :set_up_wedding

  def set_up_wedding
    if current_wedding.nil? && params[:controller] != 'weddings'
      redirect_to new_wedding_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    invitations_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def current_wedding
    current_member.weddings.first
  end

  def get_filter
    filter_id = params[:filter_id] || 0
    @filter = Filter.find(filter_id) 
  end
  hide_action :get_filter
end
