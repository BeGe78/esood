require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for access control for a user with customer role
class AdminCustomerTest < Capybara::Rails::TestCase
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
  test 'admin_customer_nok' do
    [:en, :fr].each do |lang|  
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)  
      click_button('adm_lang')
      assert_selector 'a#lang_fr', 'LoginTest::lang assert lang menu'
      puts('LoginTest::lang assert lang menu')
      click_link(%(lang_#{I18n.locale}))
      click_button('adm_user')
      assert_selector 'a#login'
      puts('AdminCustomerTest::login assert login menu')    
      click_link('login')
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: '12345678'
      click_button 'user_login'
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_in')
      puts(%(AdminCustomerTest::login assert flash '#{I18n.t('devise.sessions.signed_in')}'))
      assert_no_selector 'button#admin'
      puts('LoginTest::lang assert no admin menu')    
      
      %w(countries/new indicators/new roles plans invoicing_ledger_items admin/users).each do |controller|        
        visit I18n.locale.to_s << '/' << controller
        assert_selector 'div.alert', text: I18n.t('access_denied')
        puts('AdminCustomerTest::admin_customer_' << controller << '_nok assert flash' << I18n.t('access_denied'))
      end
      visit I18n.locale.to_s << '/countries'
      assert_text 'FRA'
      puts('AdminCustomerTest::admin_customer_countries_ok assert FRA')      
      visit I18n.locale.to_s << '/indicators'
      assert_text 'NE.RSB.GNFS.ZS'
      puts('AdminCustomerTest::admin_customer_countries_ok assert flash NE.RSB.GNFS.ZS')      
      
      click_button('adm_user')
      assert_selector 'a#logout'
      puts('AdminCustomerTest::logout assert logout menu')    
      click_link('logout')
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_out')
      puts(%(AdminCustomerTest::logout assert flash '#{I18n.t('devise.sessions.signed_out')}'))    
    end
  end
end
