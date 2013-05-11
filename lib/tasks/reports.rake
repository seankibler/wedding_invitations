namespace :reports do
  desc "Weddings report"
  task weddings: :environment do
    weddings = Wedding.all
    if weddings.count > 1
      ReportNotification.weddings(weddings).deliver
    end
  end
end
