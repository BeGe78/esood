require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for access control for a user with admin role
class AdminAdmTest < Capybara::Rails::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role.id)
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
  test 'admin_adm_nok' do
    [:en, :fr].each do |lang| 
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)    
      click_button('adm_lang')
      assert_selector 'a#lang_fr'
      puts('AdminAdmTest::lang assert lang menu')    
      click_link(%(lang_#{I18n.locale}))
      click_button('adm_user')
      assert_selector 'a#login'
      puts('AdminAdmTest::login assert login menu')    
      click_link('login')
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: '12345678'
      click_button 'user_login'
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_in')
      puts(%(AdminAdmTest::login assert flash '#{I18n.t('devise.sessions.signed_in')}'))
      assert_selector 'button#admin'
      puts('AdminAdmTest::lang assert admin menu')
    
      visit I18n.locale.to_s << '/admin/users'
      assert_text 'gmail'
      puts('AdminAdmTest::admin_adm_roles_ok assert flash users')
      visit I18n.locale.to_s << '/roles'
      assert_text 'Admin'
      puts('AdminAdmTest::admin_adm_roles_ok assert flash roles')

      visit I18n.locale.to_s << '/countries'
      assert_text 'FRA'
      puts('AdminAdmTest::admin_adm_countries_ok assert flash FRA')
      assert_text 'DEU'
      puts('AdminAdmTest::admin_adm_countries_ok assert flash DEU')
      visit I18n.locale.to_s << '/indicators'
      assert_text 'NE.RSB.GNFS.ZS'
      puts('AdminAdmTest::admin_adm_countries_ok assert flash NE.RSB.GNFS.ZS')
      click_button('adm_user')
      assert_selector 'a#logout'
      puts('AdminAdmTest::logout assert logout menu')    
      click_link('logout')
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_out')
      puts(%(AdminAdmTest::logout assert flash '#{I18n.t('devise.sessions.signed_out')}'))    
    end
  end
end
