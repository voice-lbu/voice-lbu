require 'rufus-scheduler'

s = Rufus::Scheduler.singleton max_work_threads: 1

s.every '1m' do
  Invoice.where(sent_at: nil).each do |i|
    InvoiceMailer.invoice(i).deliver
    i.update! sent_at: Time.now
  end
end
