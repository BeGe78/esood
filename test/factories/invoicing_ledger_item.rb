FactoryBot.define do
  factory :invoice1, class: InvoicingLedgerItem do
    sender_id 1
    recipient_id 2
    currency 'eur'
  end
  factory :invoice2, class: InvoicingLedgerItem do
    sender_id 3
    recipient_id 4
    currency 'eur'
  end
end
