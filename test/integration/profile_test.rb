require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class ProfileTest < Capybara::Rails::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium     
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role1.id)
  end
  teardown do
    DatabaseCleaner.clean
  end
  
  test "profile ok" do
    I18n.locale = :en
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    click_link(%Q!lang_#{I18n.locale.to_s}!)
    click_button('adm_user') 
    assert_no_selector 'a#profile'; puts("ProfileTest::profile_ok assert_no profile menu")
    click_link('register')
# logon user
    fill_in "user_name", with: 'Test1'
    fill_in "user_password", with: '12345678'
    fill_in "user_password_confirmation", with: '12345678'
    fill_in "user_company_name", with: 'Comp1'
    assert_selector('div#stripe_button', visible: false)
    puts("ProfileTest::profile_ok assert stripe button not visible")
    find('#user_remember_me',visible:  true).click
    assert_selector('div#stripe_button', visible: true)
    puts("ProfileTest::profile_ok assert stripe button visible")
    page.execute_script "window.scrollBy(0,10000)"
    find('button.stripe-button-el',visible:  true,match: :first).click
    sleep(2)
    find('iframe.stripe_checkout_app')
    within_frame(page.find('iframe.stripe_checkout_app')) do
      find('input#email.control').set %Q!test_for_profile@gmail.com!
      page.execute_script(%Q{ $('input#card_number').val('4242424242424242'); })
      page.execute_script(%Q{ $('input#cc-exp').val('07/20'); })
      find('input#cc-csc.control').set "123"
      find('button#submitButton').click
    end
    sleep(10)
    assert_selector "div.alert", text: I18n.t('devise.registrations.signed_up')
# change profile
  
  for lang in [ :en, :fr]
  I18n.locale = lang
  click_button('adm_lang')
  click_link(%Q!lang_#{I18n.locale.to_s}!)    
   for change in ['name','company','password', 'reset_password']   
    click_button('adm_user') 
    assert_selector 'a#profile'; puts("ProfileTest::profile_ok assert profile menu")
    click_link('profile')
    fill_in "user_current_password", with: '12345678'
    if change == 'name'
      fill_in "user_name", with: 'Test2'
    end
    if change == 'company'
      fill_in "user_company_name", with: 'Comp2'
    end
    if change == 'password'
      fill_in "user_password", with: '01234567'
      fill_in "user_password_confirmation", with: '01234567'
    end
    if change == 'reset_password'
      fill_in "user_password", with: '12345678'
      fill_in "user_password_confirmation", with: '12345678'
      fill_in "user_current_password", with: '01234567'
    end
    
    find('input#modify').click
    assert_selector "div.alert", text: I18n.t('devise.registrations.updated')
    puts(%Q!LoginTest::profile_#{change}_ok flash "#{I18n.t('devise.registrations.updated')}"!)
   end    
  end   

  end

  test "profile ko" do
   for error in ["card_number", "name", "password"]   
    for lang in [ :en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    assert_selector 'a#lang_fr'; puts("ProfileTest::lang assert lang menu")
    click_link(%Q!lang_#{I18n.locale.to_s}!)
    click_button('adm_user') 
    assert_selector 'a#register'; puts("ProfileTest::profile_ko assert logon menu")
    click_link('register')

    fill_in "user_name", with: 'Test1'
    if error == "name"
      fill_in "user_name", with: ''
    end  
    fill_in "user_password", with: '12345678'
    fill_in "user_password_confirmation", with: '12345678'
    if error == "password"
      fill_in "user_password_confirmation", with: '01234567'
    end  
    fill_in "user_company_name", with: 'Comp1'
    assert_selector('div#stripe_button', visible: false)
    puts("ProfileTest::profile_ko assert stripe button not visible")
    find('#user_remember_me',visible:  true).click
    assert_selector('div#stripe_button', visible: true)
    puts("ProfileTest::profile_ko assert stripe button visible")
    page.execute_script "window.scrollBy(0,10000)"
    find('button.stripe-button-el',visible:  true,match: :first).click
    sleep(2)
    find('iframe.stripe_checkout_app')
    within_frame(page.find('iframe.stripe_checkout_app')) do
      find('input#email.control').set %Q!test_ko_#{lang.to_s}@gmail.com!
      page.execute_script(%Q{ $('input#card_number').val('4242424242424242'); })
      if error == "card_number"
          page.execute_script(%Q{ $('input#card_number').val('4000000000000341'); })
      end    
      page.execute_script(%Q{ $('input#cc-exp').val('07/20'); })
      find('input#cc-csc.control').set "123"
      find('button#submitButton').click
    end
    sleep(10)
    case error
    when "card_number"    
      assert_selector "div.alert", text: I18n.t('stripe_card_error')
      puts(%Q!LoginTest::profile_ko flash "#{I18n.t('stripe_card_error')}"!)
    when "name"    
      assert_selector "div.alert", text: I18n.t('name_blanck_error')
      puts(%Q!LoginTest::profile_ko flash "#{I18n.t('name_blanck_error')}"!)  
    when "password"
      assert_selector "div.alert", text: I18n.t('password_confirmation_error')
      puts(%Q!LoginTest::profile_ko flash "#{I18n.t('password_confirmation_error')}"!)
    end  
    click_button('adm_user') 
    assert_selector 'a#register'; puts("ProfileTest::profile_ko assert logon menu")   
    end
   end
  end
  
  
end
