class InvoiceMailer < ActionMailer::Base
  include MailerHelper

  default from: 'uwe@kubosch.no'

  def invoice(invoice)
    @invoice = invoice
    attachments["Voice_#{invoice.created_at.year}.pdf"] = invoice.pdf
    mail to: safe_email(invoice.member),
        subject: voice_prefix("Medlemsavgift #{invoice.created_at.year}")
  end
end
