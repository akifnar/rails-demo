class ErrorMailer < ApplicationMailer
  default to: "admin@example.com"

  def error_notification(message, backtrace)
    @message = message
    @backtrace = backtrace
    mail subject: "Application Failure !"
  end
end
