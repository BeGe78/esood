require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for login and logout
class LoginTest < Capybara::Rails::TestCase
  include FactoryBot::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium     
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user, role_id: @role1.id)
  end
  teardown do
    DatabaseCleaner.clean
  end
  # Successful tests  with language :en and :fr    
  test 'login_and_logout' do
    [:en, :fr].each do |lang|  
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)
      assert_no_selector 'button#admin'
      puts('LoginTest::lang assert no admin menu')
      click_button('adm_lang')
      assert_selector 'a#lang_fr'
      puts('LoginTest::lang assert lang menu')
      assert_selector 'a#lang_fr'
      puts('LoginTest::lang assert lang menu')
      click_link(%(lang_#{I18n.locale}))
      click_button('adm_user') 
      assert_selector 'a#login'
      puts('LoginTest::login_and_logout assert login menu')
      click_link('login')
  
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: '12345678'
      click_button 'user_login'
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_in')
      puts(%(LoginTest::login_and_logout assert flash '#{I18n.t('devise.sessions.signed_in')}'))
      assert_selector 'a#logout', visible: false
      puts('LoginTest::login_and_logout assert logout menu')
  
      click_button('b_indicator')
      click_button('b_country')
      click_button('adm_user')
      assert_selector 'a#logout'
      puts('LoginTest::login_and_logout assert logout menu')
      click_link('logout')
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_out')
      puts(%(LoginTest::login_and_logout assert flash '#{I18n.t('devise.sessions.signed_out')}'))
      assert_selector 'a#login', visible: false
      puts('LoginTest::login_and_logout assert login menu')
    end
  end
  # Unsuccessful tests due to wrong parameters with language :en and :fr
  test 'login_fail' do
    [:en, :fr].each do |lang|  
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)
      click_button('adm_lang')
      assert_selector 'a#lang_fr'
      puts('LoginTest::lang assert lang menu')
      click_link(%(lang_#{I18n.locale}))
      click_button('adm_user')
      assert_selector 'a#login'
      puts('LoginTest::login_fail assert login menu')
      click_link('login')
  
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: '00000000'
      click_button 'user_login'
  
      assert_selector 'div.alert', text: I18n.t('devise.failure.invalid').last(9)
      puts(%(LoginTest::login_and_logout assert flash '#{I18n.t('devise.failure.invalid').last(9)}'))
      assert_selector 'a#login', visible: false
      puts('LoginTest::login_fail assert login menu')
    end
  end  
end
