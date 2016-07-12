module Test
require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class AdminAnonymousTest < Capybara::Rails::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role1.id)
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

  test "admin anonymous nok" do
    for lang in [:en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    assert_selector 'a#lang_fr'; puts("LoginTest::lang assert lang menu")
    click_link(%Q!lang_#{I18n.locale.to_s}!)
   
    for controller in ["countries/new","indicators/new","roles","plans","invoicing_ledger_items","admin/users"]        
      visit %Q!#{I18n.locale.to_s << "/" << controller}!
      assert_selector "div.alert", text: I18n.t('access_denied')
      puts("AdminAnonymousTest::admin_anonymous_" << %Q!#{controller}! << "_nok assert flash" << %Q!#{I18n.t('access_denied')}!)
    end
   
      visit %Q!#{I18n.locale.to_s << "/countries"}!
      assert_text "FRA" 
      puts("AdminAnonymousTest::admin_anonymous_countries_ok assert flash FRA")
      assert_no_text "DEU" 
      puts("AdminAnonymousTest::admin_anonymous_countries_nok assert flash DEU")
      visit %Q!#{I18n.locale.to_s << "/indicators"}!
      assert_text "NY.GDP.PCAP.CN" 
      puts("AdminAnonymousTest::admin_anonymous_indicators_ok assert flash NY.GDP.PCAP.CN")
      assert_no_text "NY.GDP.PCAP.CD" 
      puts("AdminAnonymousTest::admin_anonymous_indicators_nok assert flash NY.GDP.PCAP.CD")
    end
  end
end
end
