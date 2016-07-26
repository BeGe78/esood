require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of the {IndicatorsController **IndicatorsController**}  
class IndicatorsControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role.id)
    @user1 = FactoryGirl.create(:user1, role_id: @role1.id)
    @indicator = FactoryGirl.create(:indic1)
    sign_in @user
  end
  teardown do
    DatabaseCleaner.clean
  end
# test that index is accepted for admin user  
  test "should_get_index" do
    get :index
    assert_response :success, "IndicatorsControllerTest::shoud_get_index assert success"
    puts("IndicatorsControllerTest::shoud_get_index assert success")
    assert_not_nil assigns(:indicators), "IndicatorsControllerTest::shoud_get_index assert not_nil"
    puts("IndicatorsControllerTest::shoud_get_index assert not_nil")
  end
# test that new is accepted for admin user  
  test "should_get_new" do
    get :new
    assert_response :success, "IndicatorsControllerTest::shoud_get_new assert success"
    puts("IndicatorsControllerTest::shoud_get_new assert success")
  end
# test that create is accepted for admin user  
  test "should_create" do
    assert_difference 'Indicator.count', 1, "IndicatorsControllerTest::shoud_create assert Indicator.count +1" do
      post :create, indicator: {id1: "AG.SRF.TOTL.K2", name: "Indicator1", language: "fr", topic: "topic"}
    end
    puts("IndicatorsControllerTest::shoud_create assert Indicator.count +1")
    assert_response :success, "IndicatorsControllerTest::shoud_create assert success"
    puts("IndicatorsControllerTest::shoud_create assert success")
  end
# test that show is accepted for admin user  
  test "should_show" do
    get :show, id: @indicator
    assert_response :success, "IndicatorsControllerTest::shoud_show assert success"
    puts("IndicatorsControllerTest::shoud_show assert success")
  end
# test that edit is accepted for admin user  
  test "should_get_edit" do
    get :edit, id: @indicator
    assert_response :success, "IndicatorsControllerTest::shoud_get_edit assert success"
    puts("IndicatorsControllerTest::shoud_get_edit assert success")
  end
# test that update is accepted for admin user  
  test "should_update" do
    patch :update, id: @indicator, indicator: {name: 'name'}
    assert_redirected_to indicator_path(assigns(:indicator)), "IndicatorsControllerTest::shoud_update assert redirected_to indicator_path"
    puts("IndicatorsControllerTest::shoud_update assert redirected_to indicator_path")
  end
# test that destroy is accepted for admin user  
  test "should_destroy" do
    assert_difference 'Indicator.count', -1, "IndicatorsControllerTest::shoud_destroy assert Indicator.count -1" do
      delete :destroy, id: @indicator
    end
    assert_redirected_to indicators_path, "IndicatorsControllerTest::shoud_destroy assert redirected_to indicator_path"
    puts("IndicatorsControllerTest::shoud_destroy assert redirected_to indicator_path")
  end
end
