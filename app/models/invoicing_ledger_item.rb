# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Defines **InvoicingLedgerItem model** as used by stripe and invoicing gems.  
# Links with User model for sender and recipient to get email addresses.  
# Has many potential line items.    
class InvoicingLedgerItem < ActiveRecord::Base
  acts_as_ledger_item
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id 
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id 
  has_many :line_items, class_name: 'InvoicingLineItem', foreign_key: :ledger_item_id
end
