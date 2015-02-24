module MailerHelper
  include ApplicationHelper

  def voice_prefix(subject=nil)
    "[Voice]#{"[#{Rails.env}]" unless Rails.env.production?} #{subject}".strip
  end

  def safe_email(member)
    if Rails.env.production?
      member.emails
    else
      %Q{#{member.name} <uwe@kubosch.no>}
    end
  end

end
