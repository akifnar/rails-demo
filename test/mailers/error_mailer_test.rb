require "test_helper"

class ErrorMailerTest < ActionMailer::TestCase
  test "error_notification" do
    exception = StandardError.new("Test hatası oluştu")
    exception.set_backtrace(["file.rb:10:in 'method'"])

    mail = ErrorMailer.error_notification(exception.message, exception.backtrace)
    assert_equal "Application Failure !", mail.subject
    assert_equal [ "admin@example.com" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Test hatası oluştu", mail.body.decoded
  end
end
