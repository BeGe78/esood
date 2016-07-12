module Test
require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class SelectorTest < Capybara::Rails::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @country = FactoryGirl.create(:france)
    @country = FactoryGirl.create(:allemagne)
    @country = FactoryGirl.create(:france1)
    @country = FactoryGirl.create(:germany)
    @indicator = FactoryGirl.create(:indic1)
    @indicator = FactoryGirl.create(:indic2)
    @indicator = FactoryGirl.create(:indic3)
    @indicator = FactoryGirl.create(:indic4)
  end
  teardown do
    DatabaseCleaner.clean
  end  
  def fill_autocomplete(field, options = {})
    fill_in field, with: options[:with]
    page.execute_script %Q{ $('##{field}').trigger('focus') }
    page.execute_script %Q{ $('##{field}').trigger('keydown') }
    selector = %Q{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:select]}")}
    page.has_selector?('ul.ui-autocomplete li.ui-menu-item a')
    page.execute_script %Q{ $('#{selector}').trigger('mouseenter').click() }
  end

  test "selector" do
    Capybara.current_driver = :selenium
    
    visit root_path
    assert_selector '#fake_indicator'; puts("ControllerTest::selector assert #fake_indicator")    
    click_button('b_indicator')
    click_button('b_country')
    click_button('adm_lang')
    assert_selector 'a#lang_fr'; puts("SelectorTest::lang assert lang menu")
    click_link('lang_fr')

    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CD", select: "NY.GDP.PCAP.CD"
    fill_autocomplete "fake_country1", with: "France", select: "France"
    fill_autocomplete "fake_country2", with: "Allemagne", select: "Allemagne"

    fill_in "selector_year_begin", with: '2000'
    fill_in "selector_year_end", with: '2010'
    click_button "selector_submit"
  end
end
end
