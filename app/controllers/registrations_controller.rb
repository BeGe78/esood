# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end
  # POST /resource   Add the Stripe customer creation code
  def create
    build_resource(sign_up_params)
    puts(params[:stripeEmail])
    puts(resource.plan_id)
# check that this email has not yet been created in user table
 if User.exists?(email: params[:stripeEmail])
     redirect_to_back_or_default(alert: t('email_allready_used'))

 else     
    customer= Stripe::Customer.create(
      :email => params[:stripeEmail],         
      :source  => params[:stripeToken],
      :plan => resource.plan_id
      )
    
    resource.email = params[:stripeEmail]
    resource.stripe_card_token = params[:stripeToken]
#    resource.plan_id = params[:plan_id]
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end  
  end

  def update
    super
  end
  def destroy
# first delete Stripe customer
    cu = Stripe::Customer.retrieve(resource.customer_id)
    cu.delete
# then delete user with Devise 
    super
=begin      
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
=end
  end
def webhook
  begin
    event_json = JSON.parse(request.body.read)
    event_object = event_json['data']['object']
    #refer event types here https://stripe.com/docs/api#event_types
    case event_json['type']
      when 'invoice.payment_succeeded'
        handle_success_invoice event_object
      when 'invoice.payment_failed'
        handle_failure_invoice event_object
      when 'charge.failed'
        handle_failure_charge event_object
      when 'customer.subscription.deleted'
      when 'customer.subscription.updated'
    end
  rescue Exception => ex
    render :json => {:status => 422, :error => "Webhook call failed"}
    return
  end
  render :json => {:status => 200}
end
def redirect_to_back_or_default(*args)
  if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
    redirect_to :back, *args
  else
    redirect_to root_url, *args
  end
end

end 
