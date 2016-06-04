class StripeController < ApplicationController
  protect_from_forgery except: :webhook  
  def webhook
    begin  
    # Retrieving the event from the Stripe API guarantees its authenticity  
    event = Stripe::Event.retrieve(params[:id])
    
    case event.type
      when 'customer.created'
        # nedd to update user with customer_id for further retrieval
        user = User.where(email: event.data.object.email).first
        user.update(customer_id: event.data.object.id)
      when 'invoice.payment_succeeded'
        puts("handle_success_invoice event_object")
      when 'invoice.payment_failed'
        puts("handle_failure_invoice event_object")
      when 'charge.failed'
        puts("handle_failure_charge event_object")
      when 'customer.subscription.deleted'
      when 'customer.subscription.updated'
      else     puts("other event type")
    end
        
  rescue Exception => ex
    render :json => {:status => 422, :error => "Webhook call failed"}
    return
  end
  render :json => {:status => 200}
  end
end
