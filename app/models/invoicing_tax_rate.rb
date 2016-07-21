# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# **InvoicingTaxRate model** used by invoice gem.
class InvoicingTaxRate < ActiveRecord::Base
  acts_as_tax_rate
end
