class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_filter

  def after_sign_in_path_for(resource_or_scope)
    invitations_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def get_filter
    filter_id = params[:filter_id] || 0
    @filter = Filter.find(filter_id) 
  end
  hide_action :get_filter
end
