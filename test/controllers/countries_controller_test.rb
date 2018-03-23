require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of {CountriesController **CountriesController**} 
class CountriesControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user, role_id: @role.id)
    @user1 = FactoryBot.create(:user1, role_id: @role1.id)
    @country = FactoryBot.create(:france)
    sign_in @user1
  end
  teardown do
    DatabaseCleaner.clean
  end
  # test that index is accepted for non admin user
  test 'should_get_index' do
    get :index
    assert_response :success, 'CountriesControllerTest::shoud_get_index assert success'
    puts('CountriesControllerTest::shoud_get_index assert success')
    assert_not_nil assigns(:countries), 'CountriesControllerTest::shoud_get_index assert not_nil'
    puts('CountriesControllerTest::shoud_get_index assert not_nil')
  end
  # test that new is accepted for admin user  
  test 'should_get_new' do
    sign_out @user1
    sign_in @user  
    get :new
    assert_response :success, 'CountriesControllerTest::shoud_get_new assert success'
    puts('CountriesControllerTest::shoud_get_new assert success')
  end
  # test that create is accepted for admin user
  test 'should_create' do
    sign_out @user1
    sign_in @user
    assert_difference 'Country.count', 1, 'CountriesControllerTest::shoud_create assert Country.count +1' do
      post :create, country: { id1: 'USA', iso2code: 'US', language: 'fr', type: 'Pays' }
    end
    puts('CountriesControllerTest::shoud_create assert Country.count +1')
    assert_response :success, 'CountriesControllerTest::shoud_create assert success'
    puts('CountriesControllerTest::shoud_create assert success')
  end
  # Test the rescue of Create Indicator
  test 'rescue_create' do
    sign_out @user1
    sign_in @user
    post :create, country: { id1: @country.id }
    assert_response :redirect, 'CountriesControllerTest::rescue_create assert redirect'
    assert_redirected_to new_country_path
    puts('CountriesControllerTest::rescue_create assert redirect')
  end
  # test that create is not OK with wrong parameters for admin user
  test 'should_not_create' do
    sign_out @user1
    sign_in @user
    assert 'div.alert', text: 'Error creating country' do
      post :create, country: { id1: 'ZZZ', iso2code: 'US', language: 'fr', type: 'Pays' }
    end
    puts('CountriesControllerTest::shoud_not_create assert flash Error creating country')
  end  
  # test that show is accepted for non admin user  
  test 'should_show' do
    get :show, id: @country
    assert_response :success, 'CountriesControllerTest::shoud_show assert success'
    puts('CountriesControllerTest::shoud_show assert success')
  end
end
