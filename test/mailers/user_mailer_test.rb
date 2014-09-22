require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'login' do
    mail = UserMailer.login users(:one)
    assert_equal 'Innlogging for Voice LBU Medlemsregister', mail.subject
    assert_equal ['one@example.org'], mail.to
    assert_equal ['uwe@kubosch.no'], mail.from
    assert_match 'Hei One!', mail.body.encoded
  end

end
