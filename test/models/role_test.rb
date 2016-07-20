require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

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
  test "Role" do
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
      assert c.save
      puts(%Q!RoleTest::save assert save #{field}!)  
    else    
      assert_not c.save
      puts(%Q!RoleTest::save assert not save error #{field}!)
    end
   end 
  end
end
