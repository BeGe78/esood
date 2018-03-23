require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for logon new users mainly handled by {RegistrationsController **RegistrationsController**} 
class LogonTest < Capybara::Rails::TestCase
  include FactoryBot::Syntax::Methods
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium     
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user, role_id: @role1.id)
    @plan1 = FactoryBot.create(:plan1)
  end
  teardown do
    DatabaseCleaner.clean
  end
  # Successful tests  with language :en and :fr  
  test 'logon_ok' do
    [:en, :fr].each do |lang|  
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)
      click_button('adm_lang')
      assert_selector 'a#lang_fr'
      puts('LogonTest::lang assert lang menu')
      click_link(%(lang_#{I18n.locale}))
      click_button('adm_user') 
      assert_selector 'a#register'
      puts('LogonTest::logon_ok assert logon menu')    
      click_link('register')
  
      fill_in 'user_name', with: 'Test1'
      fill_in 'user_password', with: '12345678'
      fill_in 'user_password_confirmation', with: '12345678'
      fill_in 'user_company_name', with: 'Comp1'
      assert_selector('div#stripe_button', visible: false)
      puts('LogonTest::logon_ok assert stripe button not visible')
      find('#user_remember_me', visible:  true).click
      assert_selector('div#stripe_button', visible: true)
      puts('LogonTest::logon_ok assert stripe button visible')
      page.execute_script 'window.scrollBy(0,10000)'
      find('button.stripe-button-el', visible: true, match: :first).click
      sleep(5)
      find('iframe.stripe_checkout_app', visible: true)
      within_frame(page.find('iframe.stripe_checkout_app', visible:  true)) do
        sleep(5)  
        find('input#email.control').set %(test_ok_#{lang}@gmail.com)
        page.execute_script(%{ $('input#card_number').val('4242424242424242'); })
        page.execute_script(%{ $('input#cc-exp').val('07/20'); })
        find('input#cc-csc.control').set '123'
        find('button#submitButton').click
      end
      sleep(10)
      assert_selector 'div.alert', text: I18n.t('devise.registrations.signed_up')
      click_button('adm_user') 
      assert_selector 'a#profile'
      puts('LogonTest::logon_ok assert logoff menu')
      click_link('profile')
      find('a', text: I18n.t('Cancel_my_account')).click
      sleep(3)
      find('button.btn.commit').click
      sleep(2)
      puts('LogonTest::logon_ok assert logon1 menu')
      click_button('adm_user')
      puts('adm')
      click_link('logout')
      puts('logout')
      assert_selector 'div.alert', text: I18n.t('devise.sessions.signed_out')
      puts('logout2')
      puts(%(LoginTest::logon_ok flash '#{I18n.t('devise.sessions.signed_out')}'))   
    end
  end
  # Unsuccessful tests due to wrong parameters with language :en and :fr
  test 'logon_ko' do
    %w(card_number name password_confirmation password_length).each do |error|   
      [:en, :fr].each do |lang|  
        I18n.locale = lang
        visit %(#{I18n.locale}/selectors/new)
        click_button('adm_lang')
        assert_selector 'a#lang_fr'
        puts('LogonTest::lang assert lang menu')
        click_link(%(lang_#{I18n.locale}))
        click_button('adm_user') 
        assert_selector 'a#register'
        puts('LogonTest::logon_ko assert logon menu')
        click_link('register')
    
        fill_in 'user_name', with: 'Test1'
        fill_in 'user_name', with: '' if error == 'name'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        if error == 'password_confirmation'
          fill_in 'user_password_confirmation', with: '01234567'
        end
        if error == 'password_length'
          fill_in 'user_password', with: '0123456'
          fill_in 'user_password_confirmation', with: '0123456'
        end
        fill_in 'user_company_name', with: 'Comp1'
        assert_selector('div#stripe_button', visible: false)
        puts('LogonTest::logon_ko assert stripe button not visible')
        find('#user_remember_me', visible:  true).click
        assert_selector('div#stripe_button', visible: true)
        puts('LogonTest::logon_ko assert stripe button visible')
        page.execute_script 'window.scrollBy(0,10000)'
        find('button.stripe-button-el', visible: true, match: :first).click
        sleep(5)
        find('iframe.stripe_checkout_app', visible:  true)
        within_frame(page.find('iframe.stripe_checkout_app', visible:  true)) do
          sleep(5)  
          find('input#email.control').set %(test_ko_#{lang}@gmail.com)
          page.execute_script(%{ $('input#card_number').val('4242424242424242'); })
          if error == 'card_number'
            page.execute_script(%{ $('input#card_number').val('4000000000000341'); })
          end    
          page.execute_script(%{ $('input#cc-exp').val('07/20'); })
          find('input#cc-csc.control').set '123'
          find('button#submitButton').click
        end
        sleep(10)
        case error
        when 'card_number'
          assert_selector 'div.alert', text: I18n.t('stripe_card_error')
          puts(%(LoginTest::logon_ko flash '#{I18n.t('stripe_card_error')}'))
        when 'name'    
          assert_selector 'div.alert', text: I18n.t('name_blanck_error')
          puts(%(LoginTest::logon_ko flash '#{I18n.t('name_blanck_error')}'))  
        when 'password_confirmation'
          assert_selector 'div.alert', text: I18n.t('password_confirmation_error')
          puts(%(LoginTest::logon_ko flash '#{I18n.t('password_confirmation_error')}'))
        when 'password_length'
          assert_selector 'div.alert', text: I18n.t('password_error')
          puts(%(LoginTest::logon_ko flash '#{I18n.t('password_error')}'))
        end
        click_button('adm_user') 
        assert_selector 'a#register'
        puts('LogonTest::logon_ko assert logon menu')   
      end
    end
  end  
end
