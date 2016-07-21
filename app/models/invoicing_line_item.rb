# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# **InvoicingLineItem model** used by invoice gem.
class InvoicingLineItem < ActiveRecord::Base
  acts_as_line_item

  belongs_to :ledger_item, class_name: 'InvoicingLedgerItem'
end
