require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the REST methods of the {InvoicingLedgerItemsController **InvoicingLedgerItemsController**}  
class InvoicingLedgerItemsControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role.id)
    @user1 = FactoryGirl.create(:user1, role_id: @role1.id)
    @invoice1 = FactoryGirl.create(:invoice1)
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
    assert_response :redirect, 'InvoicingLedgerItemsControllerTest::shoud_not_get_index assert redirect'
    puts('InvoicingLedgerItemsControllerTest::shoud_not_get_index assert redirect')
  end
  # test that index is accepted for admin user  
  test 'should_get_index' do
    get :index
    assert_response :success, 'InvoicingLedgerItemsControllerTest::shoud_get_index assert success'
    puts('InvoicingLedgerItemsControllerTest::shoud_get_index assert success')
    assert_not_nil assigns(:invoicing_ledger_items), 'InvoicingLedgerItemsControllerTest::shoud_get_index assert not_nil'
    puts('InvoicingLedgerItemsControllerTest::shoud_get_index assert not_nil')
  end
  # test that index/:id is accepted for admin user  
  test 'should_get_index_id' do
    get :index, recipient_id: @invoice1.recipient_id
    assert_response :success, 'InvoicingLedgerItemsControllerTest::shoud_get_index_id assert success'
    puts('InvoicingLedgerItemsControllerTest::shoud_get_index assert success')
    assert_not_nil assigns(:invoicing_ledger_items), 'InvoicingLedgerItemsControllerTest::shoud_get_index_id assert not_nil'
    puts('InvoicingLedgerItemsControllerTest::shoud_get_index assert not_nil')
  end  
  # test that show is accepted for admin user  
  test 'should_show' do
    get :show, id: @invoice1
    assert_response :success, 'InvoicingLedgerItemsControllerTest::shoud_show assert success'
    puts('InvoicingLedgerItemsControllerTest::shoud_show assert success')
  end
  # test that destroy is accepted for admin user  
  test 'should_destroy' do
    assert_difference 'InvoicingLedgerItem.count', -1, 'InvoicingLedgerItemsControllerTest::shoud_destroy assert InvoicingLedgerItem.count -1' do
      delete :destroy, id: @invoice1
    end
    assert_redirected_to invoicing_ledger_items_path, 'InvoicingLedgerItemsControllerTest::shoud_destroy assert redirected_to plan_path'
    puts('InvoicingLedgerItemsControllerTest::shoud_destroy assert redirected_to plan_path')
  end
end
