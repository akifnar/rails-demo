require "test_helper"

class ErrorMailerTest < ActionMailer::TestCase
  test "error_notification" do
    mail = ErrorMailer.error_notification
    assert_equal "Error notification", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
