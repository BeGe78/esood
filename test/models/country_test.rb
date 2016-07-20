require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class CountryTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @france = FactoryGirl.create(:france)
  end
  teardown do
    DatabaseCleaner.clean
  end
  test "Country" do
   for field in ["duplicate", "id1", "iso2code", "code", "name", "language", "language-it", "type", "visible", "OK", "OK-duplicate"] 
    c = Country.new                 #initialize with france country
    c.id1 = @france.id1
    c.iso2code = @france.iso2code
    c.code = @france.code
    c.name = "any country"
    c.language = @france.language
    c.type = @france.type
    c.visible = @france.visible
    case field
    when "duplicate"
      c.name = @france.name
    when "id1"
      c.id1 = ""
    when "iso2code"
      c.iso2code = ""
    when "code"
      c.code = ""
    when "name"
      c.name = ""
    when "language"
      c.language = ""
    when "language-it"
      c.language = "it"  
    when "type"
      c.type = ""
    when "visible"
      c.visible = "N" 
    when "OK-duplicate"
      c.language = "en"   
    end  
    case field[0..1]
    when "OK"
      assert c.save
      puts(%Q!CountryTest::save assert save #{field}!)  
    else    
      assert_not c.save
      puts(%Q!CountryTest::save assert not save error #{field}!)
    end
   end 
  end
end
