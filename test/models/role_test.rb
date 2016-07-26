require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Tests the {Role **Role model**}
class RoleTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryGirl.create(:customer)
  end
  teardown do
    DatabaseCleaner.clean
  end
# Test **Role model** behaviour for the different fields.
  test "role" do
   for field in ["duplicate", "name", "description", "OK"] 
    c = Role.new                 #initialize with france country
    c.name = "any role"
    c.description = @role.description
    case field
    when "duplicate"
      c.name = @role.name
    when "name"
      c.name = ""
    when "description"
      c.description = ""  
    end  
    case field[0..1]
    when "OK"
      assert c.save, %Q!RoleTest::save assert save #{field}!
      puts(%Q!RoleTest::save assert save #{field}!)  
    else    
      assert_not c.save, %Q!RoleTest::save assert not save error #{field}!
      puts(%Q!RoleTest::save assert not save error #{field}!)
    end
   end 
  end
end
