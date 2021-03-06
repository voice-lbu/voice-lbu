require 'test_helper'

class InvoiceMailerTest < ActionMailer::TestCase
  test 'invoice' do
    mail = InvoiceMailer.invoice(invoices(:one))
    assert_equal "[Voice][test] Medlemsavgift #{Date.current.year}", mail.subject
    assert_equal ['uwe@kubosch.no'], mail.to
    assert_equal ['uwe@kubosch.no'], mail.from
    assert_match 'Medlemsavgift Voice Barne- og Ungdomskor', mail.body.encoded
    assert_equal 1, mail.attachments.size
    assert_equal "Voice_#{Date.current.year}.pdf", mail.attachments[0].filename
    assert_equal 'application/pdf', mail.attachments[0].mime_type
  end

end
