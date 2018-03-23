require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the email  of the {UserMailer **UserMailer**}  
class UserMailerTest < ActionMailer::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryBot.create(:admin)
    @user = FactoryBot.create(:user, role_id: @role.id)
  end
  teardown do
    DatabaseCleaner.clean
  end

  # test that new_customer_email is sent 
  test 'new_customer_email' do
    email = UserMailer.new_customer_email(@user)
    assert_equal 'New customer on ESoOD', email['subject'].to_s
    puts('UserMailerTest::OK New customer on ESoOD')
  end
  # test that payment_problem_email is sent   
  test 'payment_problem_email' do
    email = UserMailer.payment_problem_email(@user)
    assert_equal 'Payment problem on ESoOD', email['subject'].to_s
    puts('UserMailerTest::OK Payment problem on ESoOD')
  end
  # test that destroy_customer_email is sent   
  test 'destroy_customer_email' do
    email = UserMailer.destroy_customer_email(@user)
    assert_equal 'Customer deleted on ESoOD', email['subject'].to_s
    puts('UserMailerTest::OK Customer deleted on ESoOD')
  end
  # test that invoice_email is sent   
  test 'invoice_email' do
    email = UserMailer.invoice_email(@user, Rails.root.join('tmp', 'test_invoice.pdf'))
    assert_equal 'bgardin@gmail.com', email['from'].to_s
    puts('UserMailerTest::OK ESoOD Invoice')
  end  
end
