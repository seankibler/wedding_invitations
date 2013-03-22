class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_filter
  
  def get_filter
    filter_id = params[:filter_id] || 0
    @filter = Filter.find(filter_id) 
  end
  hide_action :get_filter
end
