require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of the {UsersController **UsersController**}  
class UsersControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user, role_id: @role.id)
    @user1 = FactoryBot.create(:user1, role_id: @role1.id)
    @plan = FactoryBot.create(:plan1)
    sign_in @user
  end
  teardown do
    DatabaseCleaner.clean
  end

  # test that index is refused for non admin user
  test 'should_not_get_index' do
    sign_out @user
    sign_in @user1
    get :index
    assert_response :redirect, 'UsersControllerTest::shoud_not_get_index assert redirect'
    puts('UsersControllerTest::shoud_not_get_index assert redirect')
  end
  # test that index is accepted for admin user  
  test 'should_get_index' do
    get :index
    assert_response :success, 'UsersControllerTest::shoud_get_index assert success'
    puts('UsersControllerTest::shoud_get_index assert success')
    assert_not_nil assigns(:users), 'UsersControllerTest::shoud_get_index assert not_nil'
    puts('UsersControllerTest::shoud_get_index assert not_nil')
  end
  # test that new is accepted for admin user  
  test 'should_get_new' do
    get :new
    assert_response :success, 'UsersControllerTest::shoud_get_new assert success'
    puts('UsersControllerTest::shoud_get_new assert success')
  end
  # test that create is accepted for admin user  
  test 'should_create' do
    assert_difference 'User.count', 1, 'UsersControllerTest::shoud_create assert User.count +1' do
      post :create, user: { name: 'BeGe', email: 'bege@gmail.doc', role_id: @role1.id, plan_id: @plan.id, password: '12345678', password_confirmation: '12345678' }
    end
    puts('UsersControllerTest::shoud_create assert User.count +1')
    assert_redirected_to user_path(assigns(:user)), 'PlansControllerTest::shoud_create assert redirected_to user_path'
    puts('PlansControllerTest::shoud_create assert redirected_to user_path')
  end
  # test that create is not OK with wrong parameters for admin user  
  test 'should_not_create' do
    assert 'div#error_explanation', 'UsersControllerTest::shoud_not_create assert assert div#error_explanation' do
      post :create, user: { name: 'BeGe', email: 'bege@gmail.doc', role_id: @role1.id, plan_id: @plan.id, password: '12345678', password_confirmation: '123456789' }
    end
    puts('UsersControllerTest::shoud_not_create assert assert div#error_explanation')
  end  
  # test that show is accepted for admin user  
  test 'should_show' do
    get :show, id: @user
    assert_response :success, 'UsersControllerTest::shoud_show assert success'
    puts('UsersControllerTest::shoud_show assert success')
  end
  # test that show with accepted formatted time is accepted for admin user  
  test 'should_show_with_time' do
    get :show, id: @user1
    assert_response :success, 'UsersControllerTest::shoud_show_with_time assert success'
    puts('UsersControllerTest::shoud_show_with_time assert success')
  end  
  # test that edit is accepted for admin user  
  test 'should_get_edit' do
    get :edit, id: @user
    assert_response :success, 'UsersControllerTest::shoud_get_edit assert success'
    puts('UsersControllerTest::shoud_get_edit assert success')
  end
  # test that update is accepted for admin user  
  test 'should_update' do
    patch :update, id: @user, user: { name: 'name' }
    assert_redirected_to user_path(assigns(:user)), 'UsersControllerTest::shoud_update assert redirected_to user_path'
    puts('UsersControllerTest::shoud_update assert redirected_to user_path')
  end
  # test that update is not OK for wrong parameters for admin user  
  test 'should_not_update' do
    patch :update, id: @user, user: { name: '' }
    assert 'div#error_explanation', 'UsersControllerTest::shoud_not_update assert div#error_explanation'
    puts('UsersControllerTest::shoud_not_update assert div#error_explanation')
  end
  # test that destroy is accepted for admin user  
  test 'should_destroy' do
    assert_difference 'User.count', -1, 'UsersControllerTest::shoud_destroy assert User.count -1' do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path, 'UsersControllerTest::shoud_destroy assert redirected_to user_path'
    puts('UsersControllerTest::shoud_destroy assert redirected_to user_path')
  end
end
