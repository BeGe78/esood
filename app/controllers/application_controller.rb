class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception  
  before_action :set_locale  #activation des langues, en et fr pour cette application
  before_action :configure_permitted_parameters, if: :devise_controller?

protected
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up) do |u|
     u.permit({ roles: [] }, :email, :password, :password_confirmation, :current_password, :name, :stripe_card_token, :plan_id, :invoice_count, :exp_month, :exp_year, :remember_me )
  end
  devise_parameter_sanitizer.permit(:account_update) do |u|
     u.permit({ roles: [] }, :email, :password, :password_confirmation, :current_password, :name, :stripe_card_token, :plan_id, :invoice_count, :exp_month, :exp_year, :remember_me )
  end
end

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
#  I18n.locale = :fr 
end

def default_url_options(options={})
  { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale  }
end

rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied!"
  redirect_to root_url
end
 
private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end

