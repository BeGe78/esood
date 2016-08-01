require 'test_helper'
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Tests the pdf invoice generator of the {StripeHelper **StripeHelper**}  
class StripeControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role.id)
    @user1 = FactoryGirl.create(:user1, role_id: @role1.id)
    @plan = FactoryGirl.create(:plan1)
    sign_in @user
  end
  teardown do
    DatabaseCleaner.clean
  end

  # test that index is accepted for admin user  
  test 'pdf_generation' do
    user = User.first
    product = Plan.first
    invoice = InvoicingLedgerItem.new(sender: user, recipient: user, currency: 'eur')
    invoice.line_items.build(description: product.name, net_amount: product.amount / 100, tax_amount: 0)
    invoice.save
    pdf_creator = StripeHelper::MyInvoiceGenerator.new(invoice)
    Prawn::Font::AFM.hide_m17n_warning = true
    t = Time.now.strftime '%Y-%m-%d_%H_%M_%S' # generate file name
    f = user.id.to_s + '_' + t + '.pdf'
    Dir.chdir('./tmp/')
    pdf_creator.render Rails.root.join('./tmp/', f)
    assert File.exist?(f), 'StripeControllerTest::pdf_generation OK'
    puts('StripeControllerTest::pdf_generation OK')
  end
end
