class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_stats

  def load_stats
    @guest_count = Guest.sum(:size)
    @kid_guest_count = Guest.sum(:kids)
    @addtl_guest_count = Guest.sum(:additional_guests)
    @grand_guest_count = @guest_count + @kid_guest_count + @addtl_guest_count
  end
  hide_action :load_stats
end
