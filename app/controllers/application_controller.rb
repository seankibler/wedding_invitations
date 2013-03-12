class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_stats

  def load_stats
    @kid_count = Guest.kid_count
    @addtl_guests_count = Guest.guests_count
    @guest_count = Guest.count + @kid_count + @addtl_guests_count
  end
  hide_action :load_stats
end
