require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for access control for an anonymous user
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
  # Unsuccessful tests due to access control with language :en and :fr
  test 'admin_anonymous_nok' do
    [:en, :fr].each do |lang|  
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)
      assert_no_selector 'button#admin'
      puts('AdminAnonymousTest::lang assert no admin menu')    
      click_button('adm_lang')
      assert_selector 'a#lang_fr'
      puts('AdminAnonymousTest::lang assert lang menu')    
      click_link(%(lang_#{I18n.locale}))
   
      %w(countries/new indicators/new roles plans invoicing_ledger_items admin/users).each do |controller|        
        visit I18n.locale.to_s << '/' << controller
        assert_selector 'div.alert', text: I18n.t('access_denied')
        puts('AdminAnonymousTest::admin_anonymous_' << controller << '_nok assert flash' << I18n.t('access_denied'))
      end   
      visit I18n.locale.to_s << '/countries'
      assert_text 'FRA'
      puts('AdminAnonymousTest::admin_anonymous_countries_ok assert flash FRA')
      assert_no_text 'DEU'
      puts('AdminAnonymousTest::admin_anonymous_countries_nok assert flash DEU')
      visit I18n.locale.to_s << '/indicators'
      assert_text 'NE.RSB.GNFS.ZS'
      puts('AdminAnonymousTest::admin_anonymous_indicators_ok assert flash NE.RSB.GNFS.ZS')
      assert_no_text 'NY.GDP.PCAP.CD'
      puts('AdminAnonymousTest::admin_anonymous_indicators_nok assert flash NY.GDP.PCAP.CD')
    end
  end
end
