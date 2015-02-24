json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :member_id, :amount, :sent_at, :paid_at
  json.url invoice_url(invoice, format: :json)
end
