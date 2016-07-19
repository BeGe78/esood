class StripeController < ApplicationController
  protect_from_forgery except: :webhook
  
  def webhook
    begin  
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
        if !user.company_name.nil?
            then
       # get language of User and force I18n.locale to get the invoice in right language
            locale_save = I18n.locale
            I18n.locale = user.language.to_sym
            product = Plan.where(stripe_id: user.plan_id).first
            invoice = InvoicingLedgerItem.new(sender: user,  recipient: user, currency: 'eur')
            invoice.line_items.build(description: product.name, net_amount: product.amount/100 , tax_amount: 0)
            invoice.save
        # pdf creation    
            pdf_creator = StripeHelper::MyInvoiceGenerator.new(invoice)
            Prawn::Font::AFM.hide_m17n_warning = true
            t = Time.now.strftime "%Y-%m-%d_%H_%M_%S"            #generate file name
            f = user.id.to_s + "_" + t + ".pdf"
            pdf_file = pdf_creator.render Rails.root.join("./public/",f)
            #UserMailer.invoice_email(user.email, Rails.root.join("./public/",f).to_s).deliver_later
            UserMailer.invoice_email("bgardin@gmail.com", Rails.root.join("./public/",f).to_s).deliver_later
            I18n.locale = locale_save
        end
      when 'invoice.payment_failed'
        # need to send email for manual handling  
        puts("handle_failure_invoice event_object")
        UserMailer.payment_problem_email.deliver_later
      when 'charge.failed'
        # need to send email for manual handling
        puts("handle_failure_charge event_object")
        user = User.where(email: event.data.object.source.name).first
        UserMailer.payment_problem_email(user).deliver_later
      when 'customer.deleted'
        # need to send email for manual handling
        puts("handle_customer.deleted event_object")
        UserMailer.destroy_customer_email(event.data.object.email).deliver_later  
      else     puts("other event type")
    end
        
  rescue Exception => ex
    render :json => {:status => 422, :error => "Webhook call failed"}
    return
  end
  render :json => {:status => 200}
  end
end 
