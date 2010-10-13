class InquiryMailer < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.inquiry_mailer.inquiry_received.subject
  #
  def inquiry_received(inquiry)
    @inquiry = inquiry
    
    mail :to => Setting.get(:email), :from => Setting.get(:default_from_email)
  end
end
