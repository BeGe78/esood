require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class LoginTest < Capybara::Rails::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium
     
     @role = FactoryGirl.create(:admin)
     @role = FactoryGirl.create(:customer)
     @user = FactoryGirl.create(:user)
  end
  teardown do
    DatabaseCleaner.clean
  end
  
  test "login and logout" do
    visit root_path
    click_button('b_indicator')
    click_button('b_country')
    click_button('adm_user')
    assert_selector 'a#login'; puts("LoginTest::login_and_logout assert login menu")
    click_link('login')

    fill_in "user_email", with: 'test@gmail.com'
    fill_in "user_password", with: '12345678'
    click_button "user_login"
    assert "Connecté."; puts("LoginTest::login_and_logout assert flash Connecté.")
    assert_selector 'a#logout', visible: false; puts("LoginTest::login_and_logout assert logout menu")

    click_button('b_indicator')
    click_button('b_country')
    click_button('adm_user')
    assert_selector 'a#logout'; puts("LoginTest::login_and_logout assert logout menu")
    click_link('logout')
    assert "Déconnecté."; puts("LoginTest::login_and_logout assert flash Déconnecté.")
    assert_selector 'a#login', visible: false; puts("LoginTest::login_and_logout assert login menu")
  end
    test "login fail" do
    visit root_path
    click_button('adm_user')
    assert_selector 'a#login'; puts("LoginTest::login_fail assert login menu")
    click_link('login')

    fill_in "user_email", with: 'test@gmail.com'
    fill_in "user_password", with: '00000000'
    click_button "user_login"

    assert "Email ou mot de passe incorrect."; puts("LoginTest::login_and_logout assert flash Mot de passe incorrect.")
    assert_selector 'a#login', visible: false; puts("LoginTest::login_fail assert login menu")                   
  end
  
end
