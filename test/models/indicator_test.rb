require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Tests the {Indicator **Indicator model**}  
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
  # Test **Indicator model** behaviour for the different fields.  
  test 'indicator' do
    ['duplicate', 'id1', 'topic', 'name', 'language', 'language-it', 'visible', 'OK', 'OK-duplicate'].each do |field|
      c = Indicator.new # initialize with france country
      c.id1 = 'ANY.INDIC'
      c.topic = @indic.topic
      c.name = @indic.name
      c.language = @indic.language
      c.visible = @indic.visible
      case field
      when 'duplicate'
        c.id1 = @indic.id1
      when 'id1'
        c.id1 = ''
      when 'topic'
        c.topic = ''
      when 'name'
        c.name = ''
      when 'language'
        c.language = ''
      when 'language-it'
        c.language = 'it'  
      when 'visible'
        c.visible = 'N' 
      when 'OK-duplicate'
        c.language = 'en'   
      end  
      case field[0..1]
      when 'OK'
        assert c.save
        puts(%(IndicatorTest::save assert save #{field}))  
      else    
        assert_not c.save
        puts(%(IndicatorTest::save assert not save error #{field}))
      end
    end 
  end
end
