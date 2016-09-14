# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Handles Asynchronous Events coming from stripe and feed the user table, produce invoice if requested, 
# send email to admin mailbox and send SMS to admin mobile phone.
# {StripeControllerTest Corresponding tests:}   
# ![Class Diagram](diagram/stripe_controller_diagram.png)
class StripeController < ApplicationController
  protect_from_forgery except: :webhook
  # Activated from stripe services.  
  # Analyse the event type and react accordingly.  
  # @return [User.update, invoices, mail, SMS] 
  # @rest_url POST /stripe/webhook(.:format) 
  # @path stripe_webhook
  def webhook
    # Retrieving the event from the Stripe API guarantees its authenticity  
    event = Stripe::Event.retrieve(params[:id])   
    case event.type
    when 'customer.created'
      # need to update user with customer_id for further retrieval
      user = User.where(email: event.data.object.email).first
      user.update(customer_id: event.data.object.id)
      UserMailer.new_customer_email(user).deliver_later
    when 'customer.source.created'
      # need to update card expiration date
      user = User.where(email: event.data.object.name).first
      user.update(exp_month: event.data.object.exp_month)
      user.update(exp_year: event.data.object.exp_year)
    when 'invoice.payment_succeeded'
      # need to increment invoice_count
      user = User.where(customer_id: event.data.object.customer).first
      user.update(invoice_count: (user.invoice_count + 1))
      # send invoice if user has filled the company name
      unless user.company_name.nil?
        # get language of User and force I18n.locale to get the invoice in right language
        locale_save = I18n.locale
        I18n.locale = user.language.to_sym
        product = Plan.where(stripe_id: user.plan_id).first
        invoice = InvoicingLedgerItem.new(sender: user, recipient: user, currency: 'eur')
        invoice.line_items.build(description: product.name, net_amount: product.amount / 100, tax_amount: 0)
        invoice.save
        # pdf creation    
        pdf_creator = StripeHelper::MyInvoiceGenerator.new(invoice)
        Prawn::Font::AFM.hide_m17n_warning = true
        t = Time.now.strftime '%Y-%m-%d_%H_%M_%S' # generate file name
        f = user.id.to_s + '_' + t + '.pdf'
        pdf_creator.render Rails.root.join('./tmp/invoice_pdf', f)
        UserMailer.invoice_email('bgardin@gmail.com', Rails.root.join('./tmp/invoice_pdf', f).to_s).deliver_later
        I18n.locale = locale_save
      end
    when 'invoice.payment_failed'
      # need to send email for manual handling  
      puts('handle_failure_invoice event_object')
      UserMailer.payment_problem_email.deliver_later
    when 'charge.failed'
      # need to send email for manual handling
      puts('handle_failure_charge event_object')
      user = User.where(email: event.data.object.source.name).first
      UserMailer.payment_problem_email(user).deliver_later
    when 'customer.deleted'
      # need to send email for manual handling
      puts('handle_customer.deleted event_object')
      UserMailer.destroy_customer_email(event.data.object.email).deliver_later  
    else puts('other event type')
    end
    render json: { status: 200 }
  rescue StandardError
    render json: { status: 422, error: 'Webhook call failed' }
    return
  end
end 
