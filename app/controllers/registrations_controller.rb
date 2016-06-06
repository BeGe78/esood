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
# create Stripe customer first      
      customer= Stripe::Customer.create(
      :email => params[:stripeEmail],         
      :source  => params[:stripeToken],
      :plan => resource.plan_id
      )
# create Devise user    
      resource.email = params[:stripeEmail]
      resource.stripe_card_token = params[:stripeToken]
      resource.invoice_count = 1   #need to initialize to 1 because customer.created event can arrive after
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
    cu = Stripe::Customer.retrieve(resource.customer_id)
    cu.email = params[:user][:email]   #we need to update the email in case it has been modified
    cu.save
    super
  end
  def destroy
# first delete Stripe customer
    cu = Stripe::Customer.retrieve(resource.customer_id)
    cu.delete
# then delete user with Devise 
    super
  end

def redirect_to_back_or_default(*args)
  if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
    redirect_to :back, *args
  else
    redirect_to root_url, *args
  end
end

end 
