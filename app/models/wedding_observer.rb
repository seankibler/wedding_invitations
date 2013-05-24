class WeddingObserver < ActiveRecord::Observer
  def after_create(wedding)
    ReportNotification.new_wedding(wedding).deliver
  end
end
