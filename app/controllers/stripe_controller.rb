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
      when 'customer.source.created'
        # need to update card expiration date
        user = User.where(email: event.data.object.name).first
        user.update(exp_month: event.data.object.exp_month)
        user.update(exp_year: event.data.object.exp_year)
      when 'invoice.payment_succeeded'
        # need to increment invoice_count
        user = User.where(customer_id: event.data.object.customer).first
        user.update(invoice_count: (user.invoice_count + 1))
      when 'invoice.payment_failed'
        # need to send email for manual handling  
        puts("handle_failure_invoice event_object")
      when 'charge.failed'
        # need to send email for manual handling
        puts("handle_failure_charge event_object")
      else     puts("other event type")
    end
        
  rescue Exception => ex
    render :json => {:status => 422, :error => "Webhook call failed"}
    return
  end
  render :json => {:status => 200}
  end
end
