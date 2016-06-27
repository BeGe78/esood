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
# initialize empty fields    
    resource.email = params[:stripeEmail]
    resource.stripe_card_token = params[:stripeToken]
    resource.invoice_count = 1   #need to initialize to 1 because customer.created event can arrive after
    resource.valid?
    puts(resource.errors.messages)
    puts(resource.errors.messages.length)
# check if the user models verifications are good
    if resource.errors.messages.length > 0    # there is at least an error
     case resource.errors.keys.first
      when :password_confirmation
          redirect_to_back_or_default(alert: t('password_confirmation_error'))
      when :email
          redirect_to_back_or_default(alert: t('email_allready_used'))
      when :password
          redirect_to_back_or_default(alert: t('password_blanck_error'))
      when :name
          redirect_to_back_or_default(alert: t('name_blanck_error'))
      else 
          redirect_to_back_or_default(alert: t('user_parameter_error'))
    end        
# check that this email has not yet been created in user table
    elsif User.exists?(email: params[:stripeEmail])
      redirect_to_back_or_default(alert: t('email_allready_used'))
    else     
# create Stripe customer first
      begin  
      customer= Stripe::Customer.create(
      :email => params[:stripeEmail],         
      :source  => params[:stripeToken],
      :plan => resource.plan_id
      )
      rescue Stripe::CardError => e
          flash[:notice] = t('stripe_card_error')
          redirect_to new_selector_path and return
      rescue Stripe::StripeError => e
          flash[:notice] = t('stripe_error')
          redirect_to new_selector_path and return    
      end 
      
# create Devise user    
      resource.language = I18n.locale.to_s
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          system 'sms_create_user.sh'
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
    begin
    cu = Stripe::Customer.retrieve(resource.customer_id)
    cu.email = params[:user][:email]   #we need to update the email in case it has been modified
    cu.save
    rescue Stripe::StripeError => e
          flash[:notice] = t('stripe_error')
          redirect_to edit_user_registration_path and return
    end
    super
  end
  def destroy
# first delete Stripe customer
    begin
    cu = Stripe::Customer.retrieve(resource.customer_id)
    cu.delete
    rescue Stripe::StripeError => e
          flash[:notice] = t('stripe_error')
          redirect_to edit_user_registration_path and return
    end
# then delete user with Devise 
    super
    system 'sms_delete_user.sh'
end

def redirect_to_back_or_default(*args)
  if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
    redirect_to :back, *args
  else
    redirect_to root_url, *args
  end
end

end 
