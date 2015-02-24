require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'login' do
    mail = UserMailer.login users(:one)
    assert_equal '[Voice][test] Innlogging for Voice LBU Medlemsregister', mail.subject
    assert_equal ['uwe@kubosch.no'], mail.to
    assert_equal ['uwe@kubosch.no'], mail.from
    assert_match 'Hei One!', mail.body.encoded
  end

end
