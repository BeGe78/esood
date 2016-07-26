require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of {CountriesController **CountriesController**} 
class CountriesControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role.id)
    @user1 = FactoryGirl.create(:user1, role_id: @role1.id)
    @country = FactoryGirl.create(:france)
    sign_in @user
  end
  teardown do
    DatabaseCleaner.clean
  end
# test that index is accepted for non admin user
  test "should_get_index" do
    get :index
    assert_response :success, "CountriesControllerTest::shoud_get_index assert success"
    puts("CountriesControllerTest::shoud_get_index assert success")
    assert_not_nil assigns(:countries), "CountriesControllerTest::shoud_get_index assert not_nil"
    puts("CountriesControllerTest::shoud_get_index assert not_nil")
  end
# test that new is accepted for non admin user  
  test "should_get_new" do
    get :new
    assert_response :success, "CountriesControllerTest::shoud_get_new assert success"
    puts("CountriesControllerTest::shoud_get_new assert success")
  end
# test that create is accepted for non admin user
  test "should_create" do
    assert_difference 'Country.count', 1, "CountriesControllerTest::shoud_create assert Country.count +1" do
      post :create, country: {id1: "USA", iso2code: "US", language: "fr", type: "Pays"}
    end
    puts("CountriesControllerTest::shoud_create assert Country.count +1")
    assert_response :success, "CountriesControllerTest::shoud_create assert success"
    puts("CountriesControllerTest::shoud_create assert success")
  end
# test that show is accepted for non admin user  
  test "should_show" do
    get :show, id: @country
    assert_response :success, "CountriesControllerTest::shoud_show assert success"
    puts("CountriesControllerTest::shoud_show assert success")
  end
end
