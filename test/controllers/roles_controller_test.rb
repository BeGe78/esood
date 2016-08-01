require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of the {RolesController **RolesController**}  
class RolesControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role.id)
    sign_in @user
  end
  teardown do
    DatabaseCleaner.clean
  end
  # test that index is refused for non admin user
  test 'should_not_get_index' do
    @user1 = FactoryGirl.create(:user1, role_id: @role1.id)
    sign_out @user
    sign_in @user1
    get :index
    assert_response :redirect, 'RolesControllerTest::shoud_not_get_index assert redirect'
    puts('RolesControllerTest::shoud_not_get_index assert redirect')
  end
  # test that index is accepted for admin user  
  test 'should_get_index' do
    get :index
    assert_response :success, 'RolesControllerTest::shoud_get_index assert success'
    puts('RolesControllerTest::shoud_get_index assert success')
    assert_not_nil assigns(:roles), 'RolesControllerTest::shoud_get_index assert not_nil'
    puts('RolesControllerTest::shoud_get_index assert not_nil')
  end
  # test that new is accepted for admin user  
  test 'should_get_new' do
    get :new
    assert_response :success, 'RolesControllerTest::shoud_get_new assert success'
    puts('RolesControllerTest::shoud_get_new assert success')
  end
  # test that create is accepted for admin user  
  test 'should_create' do
    assert_difference 'Role.count', 1, 'RolesControllerTest::shoud_create assert Role.count +1' do
      post :create, role: { name: 'Usr', description: 'Desc' }
    end
    puts('RolesControllerTest::shoud_create assert Role.count +1')
    assert_redirected_to role_path(assigns(:role)), 'RolesControllerTest::shoud_create assert redirected_to role_path'
    puts('RolesControllerTest::shoud_create assert redirected_to role_path')
  end
  # test that create is not OK with wrong parameters for admin user  
  test 'should_not_create' do
    assert 'div#error_explanation', 'RolesControllerTest::shoud_not_create assert div#error_explanation' do
      post :create, role: { description: 'Desc' }
    end
    puts('RolesControllerTest::shoud_not_create assert div#error_explanation')
  end  
  # test that show is accepted for admin user  
  test 'should_show' do
    get :show, id: @role
    assert_response :success, 'RolesControllerTest::shoud_show assert success'
    puts('RolesControllerTest::shoud_show assert success')
  end
  # test that edit is accepted for admin user  
  test 'should_get_edit' do
    get :edit, id: @role
    assert_response :success, 'RolesControllerTest::shoud_get_edit assert success'
    puts('RolesControllerTest::shoud_get_edit assert success')
  end
  # test that update is accepted for admin user  
  test 'should_update' do
    patch :update, id: @role, role: { description: 'Desc' }
    assert_redirected_to role_path(assigns(:role)), 'RolesControllerTest::shoud_update assert redirected_to role_path'
    puts('RolesControllerTest::shoud_update assert redirected_to role_path')
  end
  # test that update is not OK with wrong parameters for admin user  
  test 'should_not_update' do
    patch :update, id: @role, role: { description: '' }
    assert 'div#error_explanation', 'RolesControllerTest::shoud_not_update assert div#error_explanation'
    puts('RolesControllerTest::shoud_not_update assert div#error_explanation')
  end  
  # test that destroy is accepted for admin user  
  test 'should_destroy' do
    assert_difference 'Role.count', -1, 'RolesControllerTest::shoud_destroy assert Role.count -1' do
      delete :destroy, id: @role
    end
    assert_redirected_to roles_path, 'RolesControllerTest::shoud_destroy assert redirected_to role_path'
    puts('RolesControllerTest::shoud_destroy assert redirected_to role_path')
  end
end
