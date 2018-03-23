require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Tests the {InvoicingLedgerItem **InvoicingLedgerItem model**}  
class InvoicingLedgerItemTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @invoice1 = FactoryBot.create(:invoice1)
  end
  teardown do
    DatabaseCleaner.clean
  end
  # Test **Invoicing_ledger_item model** behaviour for the different fields.  
  test 'invoicing_ledger_item' do
    ['OK'].each do |field| 
      c = InvoicingLedgerItem.new
      c.sender_id = 5
      c.recipient_id = 6
      c.currency = 'eur'
      case field[0..1]
      when 'OK'
        assert c.save, %(InvoicingLedgerItemTest::save assert save #{field})
        puts(%(InvoicingLedgerItemTest::save assert save #{field}))  
      else    
        assert_not c.save, %(InvoicingLedgerItemTest::save assert not save error #{field})
        puts(%(InvoicingLedgerItemTest::save assert not save error #{field}))
      end
    end 
  end
end
