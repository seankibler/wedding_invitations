class ReportNotification < ActionMailer::Base
  REPORT_RECIPIENTS = ['farmlywed@gmail.com', 'skibler1223@gmail.com']
  default :from => 'FarmlyWed <farmlywed@gmail.com>'

  def weddings(weddings)
    @weddings = weddings
    mail(to: REPORT_RECIPIENTS, subject: 'Weddings Report')
  end
end
