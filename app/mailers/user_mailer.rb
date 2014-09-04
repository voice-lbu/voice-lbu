class UserMailer < ActionMailer::Base
  default from: "uwe@kubosch.no"

  def login(user)
    @user = user
    mail to: user.email, subject: 'Innlogging for Voice LBU Medlemsregister'
  end
end
