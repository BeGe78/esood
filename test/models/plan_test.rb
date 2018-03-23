require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Tests the {Plan **Plan model**}
class PlanTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @plan = FactoryBot.create(:plan1)
  end
  teardown do
    DatabaseCleaner.clean
  end
  # Test **Plan model** behaviour for the different fields.  
  test 'plan' do
    %w(duplicate stripe_id name amount interval OK).each do |field|        
      c = Plan.new
      c.stripe_id = 'any period'
      c.name = @plan.name
      c.amount = @plan.amount
      c.interval = @plan.interval
      case field
      when 'duplicate'
        c.stripe_id = @plan.stripe_id
      when 'stripe_id'
        c.stripe_id = ''
      when 'name'
        c.name = ''
      when 'amount'
        c.amount = 10
      when 'interval'
        c.interval = ''  
      end  
      case field[0..1]
      when 'OK'
        assert c.save, %(PlanTest::save assert save #{field})
        puts(%(PlanTest::save assert save #{field}))  
      else    
        assert_not c.save, %(PlanTest::save assert not save error #{field})
        puts(%(PlanTest::save assert not save error #{field}))
      end
    end 
  end
end
