json.array!(@invoicing_ledger_items) do |invoice|
  json.extract! invoice, :id, :sender_id, :recipient_id
  json.url invoicing_ledger_item_url(invoice, format: :json)
end
