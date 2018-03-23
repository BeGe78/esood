require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Tests the {Role **Role model**}
class RoleTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryBot.create(:customer)
  end
  teardown do
    DatabaseCleaner.clean
  end
  # Test **Role model** behaviour for the different fields.
  test 'role' do
    %w(duplicate name description OK).each do |field|
      c = Role.new
      c.name = 'any role'
      c.description = @role.description
      case field
      when 'duplicate'
        c.name = @role.name
      when 'name'
        c.name = ''
      when 'description'
        c.description = ''  
      end  
      case field[0..1]
      when 'OK'
        assert c.save, %(RoleTest::save assert save #{field})
        puts(%(RoleTest::save assert save #{field}))  
      else    
        assert_not c.save, %(RoleTest::save assert not save error #{field})
        puts(%(RoleTest::save assert not save error #{field}))
      end
    end 
  end
end
