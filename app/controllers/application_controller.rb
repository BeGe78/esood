# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Top application controller  
# Prevent CSRF attacks by raising an exception.  
# Set language.  
# Configure permitted parameters for devise gem.
# Require WorldBank for the others.  
#![Class Diagram](file/doc/diagram/application_controller_diagram.png)
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception  
  before_action :set_locale  #language (en & fr) initialisation
  before_action :configure_permitted_parameters, if: :devise_controller?  #parameters rights for devise  
  require 'world_bank'       #world bank API

protected
# Configure permitted parameters for devise gem registration and account update
def configure_permitted_parameters  #list authorised parameters for devise registration & update
  devise_parameter_sanitizer.permit(:sign_up) do |u|
     u.permit({ roles: [] }, :email, :password, :password_confirmation, :current_password, :name, :stripe_card_token, :plan_id, :invoice_count, :exp_month, :exp_year, :remember_me, :company_name, :language )
  end
  devise_parameter_sanitizer.permit(:account_update) do |u|
     u.permit({ roles: [] }, :email, :password, :password_confirmation, :current_password, :name, :stripe_card_token, :plan_id, :invoice_count, :exp_month, :exp_year, :remember_me, :company_name, :language )
  end
end
# Set language from params or default
# @return [I18n.locale] which could be :en or :fr
def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
# Set default url with language
# @return [I18n.locale] which could be :en or :fr
def default_url_options(options={})
  { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale  }
end
# rescue cancan denied access to flash error
rescue_from CanCan::AccessDenied do |exception|  #error rescue for cancan role control
  flash[:error] = t('access_denied')
  redirect_to root_url
end
 
private
# get language from browser
# @return [language] which could be :en or :fr
def extract_locale_from_accept_language_header
  request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
end
end
