class UserMailer < ActionMailer::Base
  include MailerHelper

  default from: 'uwe@kubosch.no'

  def login(user)
    @user = user
    mail to: safe_email(user),
        subject: voice_prefix('Innlogging for Voice LBU Medlemsregister')
  end
end
