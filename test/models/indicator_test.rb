require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class IndicatorTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @indic = FactoryGirl.create(:indic1)
  end
  teardown do
    DatabaseCleaner.clean
  end
  test "Indicator" do
   for field in ["duplicate", "id1", "topic", "name", "language", "language-it", "visible", "OK", "OK-duplicate"] 
    c = Indicator.new                 #initialize with france country
    c.id1 = "ANY.INDIC"
    c.topic = @indic.topic
    c.name = @indic.name
    c.language = @indic.language
    c.visible = @indic.visible
    case field
    when "duplicate"
      c.id1 = @indic.id1
    when "id1"
      c.id1 = ""
    when "topic"
      c.topic = ""
    when "name"
      c.name = ""
    when "language"
      c.language = ""
    when "language-it"
      c.language = "it"  
    when "visible"
      c.visible = "N" 
    when "OK-duplicate"
      c.language = "en"   
    end  
    case field[0..1]
    when "OK"
      assert c.save
      puts(%Q!IndicatorTest::save assert save #{field}!)  
    else    
      assert_not c.save
      puts(%Q!IndicatorTest::save assert not save error #{field}!)
    end
   end 
  end
end
