require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for the {MyMailer mailing to customers}.  
class MyMailerTest < Capybara::Rails::TestCase
  include FactoryBot::Syntax::Methods
  include Capybara::Email::DSL
  self.use_transactional_fixtures = false 
  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium
    Capybara.server_port = 38_225
    clear_emails
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user_en, role_id: @role1.id)
    @user = FactoryBot.create(:user_fr, role_id: @role1.id) 
  end
  teardown do
    DatabaseCleaner.clean
  end
  # mailer tests with language :en and :fr  
  test 'my_mailer_ok' do
    [:en, :fr].each do |lang| 
      %w(confirmation password unlock).each do |renew|
        I18n.locale = lang
        visit %(#{I18n.locale}/selectors/new)
        click_button('adm_lang')
        assert_selector 'a#lang_fr'
        puts('MyMailerTest::my_mailer assert lang menu')    
        click_link(%(lang_#{I18n.locale}))
        # go to login screen   
        click_button('adm_user') 
        assert_selector 'a#login'
        puts('MyMailerTest::my_mailer assert login menu')    
        click_link('login')
        case renew
        when 'confirmation'    
          click_link('new_confirmation')
        when 'password'
          click_link('new_password') 
        when 'unlock'
          (1..7).each do |i| # lock the user with wrong password
            fill_in 'user_email', with: %(test_#{I18n.locale}@gmail.com)
            fill_in 'user_password', with: i
            click_button('user_login')  
          end    
          click_link('new_unlock')   
        end    
        fill_in 'user_email', with: %(test_#{I18n.locale}@gmail.com)
        click_button 'user_instructions'
        case renew
        when 'confirmation'
          assert_selector 'div.alert', text: I18n.t('devise.confirmations.send_instructions')
          puts(%(MyMailerTest::my_mailer assert flash '#{I18n.t('devise.confirmations.send_instructions')}'))
        when 'password'
          assert_selector 'div.alert', text: I18n.t('devise.passwords.send_instructions')
          puts(%(MyMailerTest::my_mailer assert flash '#{I18n.t('devise.passwords.send_instructions')}'))
        when 'unlock'
          assert_selector 'div.alert', text: I18n.t('devise.unlocks.send_instructions')
          puts(%(MyMailerTest::my_mailer assert flash '#{I18n.t('devise.unlocks.send_instructions')}'))
        end  
        assert_selector 'a#login', visible: false
        puts('MyMailerTest::my_mailer assert login menu')    
        open_email(%(test_#{I18n.locale}@gmail.com))
        current_email.find('p', text: I18n.t('Welcome'))
        puts('MyMailerTest::my_mailer assert mail text')
        case renew
        when 'confirmation'
          current_email.find('a', text: I18n.t('confirm_link')).click
          puts(%(MyMailerTest::my_mailer assert flash '#{I18n.t('devise.confirmations.confirmed')}'))
        when 'password'
          current_email.find('a', text: I18n.t('Change_my_passord')).click
          puts(%(MyMailerTest::my_mailer assert flash '#{I18n.t('devise.passwords.updated')}'))
        when 'unlock'
          current_email.find('a', text: I18n.t('Unlock_my_account')).click
          puts(%(MyMailerTest::my_mailer assert flash '#{I18n.t('devise.unlocks.unlocked')}'))
        end 
      end 
    end
  end 
end
