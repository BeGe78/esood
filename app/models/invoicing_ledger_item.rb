class InvoicingLedgerItem < ActiveRecord::Base
  acts_as_ledger_item
  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  has_many :line_items, class_name: 'InvoicingLineItem', foreign_key: :ledger_item_id
end
