require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of the {PlansController **PlansController**}  
class PlansControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user, role_id: @role.id)
    @plan = FactoryBot.create(:plan1)
    sign_in @user
  end
  teardown do
    DatabaseCleaner.clean
  end

  # test that index is refused for non admin user
  test 'should_not_get_index' do
    @user1 = FactoryBot.create(:user1, role_id: @role1.id)
    sign_out @user
    sign_in @user1
    get :index
    assert_response :redirect, 'PlansControllerTest::shoud_not_get_index assert redirect'
    puts('PlansControllerTest::shoud_not_get_index assert redirect')
  end
  # test that index is accepted for admin user  
  test 'should_get_index' do
    get :index
    assert_response :success, 'PlansControllerTest::shoud_get_index assert success'
    puts('PlansControllerTest::shoud_get_index assert success')
    assert_not_nil assigns(:plans), 'PlansControllerTest::shoud_get_index assert not_nil'
    puts('PlansControllerTest::shoud_get_index assert not_nil')
  end
  # test that new is accepted for admin user  
  test 'should_get_new' do
    get :new
    assert_response :success, 'PlansControllerTest::shoud_get_new assert success'
    puts('PlansControllerTest::shoud_get_new assert success')
  end
  # test that create is accepted for admin user  
  test 'should_create' do
    assert_difference 'Plan.count', 1, 'PlansControllerTest::shoud_create assert Plan.count +1' do
      post :create, plan: { stripe_id: 'Day-plan', name: 'Plan', amount: 2000, interval: 'day' }
    end
    puts('PlansControllerTest::shoud_create assert Plan.count +1')
    assert_redirected_to plan_path(assigns(:plan)), 'PlansControllerTest::shoud_create assert redirected_to plan_path'
    puts('PlansControllerTest::shoud_create assert redirected_to plan_path')
  end
  # test that create is not OK with wrong parameters for admin user  
  test 'should_not_create' do
    assert 'div#error_explanation', 'PlansControllerTest::shoud_not_create assert div#error_explanation' do
      post :create, plan: { stripe_id: 'Day-plan', name: 'Plan', amount: 1, interval: 'day' }
    end
    puts('PlansControllerTest::shoud_not_create assert div#error_explanation')
  end  
  # test that show is accepted for admin user  
  test 'should_show' do
    get :show, id: @plan
    assert_response :success, 'PlansControllerTest::shoud_show assert success'
    puts('PlansControllerTest::shoud_show assert success')
  end
  # test that edit is accepted for admin user  
  test 'should_get_edit' do
    get :edit, id: @plan
    assert_response :success, 'PlansControllerTest::shoud_get_edit assert success'
    puts('PlansControllerTest::shoud_get_edit assert success')
  end
  # test that update is accepted for admin user  
  test 'should_update' do
    patch :update, id: @plan, plan: { interval: 'month' }
    assert_redirected_to plan_path(assigns(:plan)), 'PlansControllerTest::shoud_update assert redirected_to plan_path'
    puts('PlansControllerTest::shoud_update assert redirected_to plan_path')
  end
  # test that update is not OK with wrong parameters for admin user  
  test 'should_not_update' do
    patch :update, id: @plan, plan: { amount: 1 }
    assert 'div#error_explanation', 'PlansControllerTest::shoud_not_update assert div#error_explanation'
    puts('PlansControllerTest::shoud_not_update assert div#error_explanation')
  end  
  # test that destroy is accepted for admin user  
  test 'should_destroy' do
    assert_difference 'Plan.count', -1, 'PlansControllerTest::shoud_destroy assert Plan.count -1' do
      delete :destroy, id: @plan
    end
    assert_redirected_to plans_path, 'PlansControllerTest::shoud_destroy assert redirected_to plan_path'
    puts('PlansControllerTest::shoud_destroy assert redirected_to plan_path')
  end
end
