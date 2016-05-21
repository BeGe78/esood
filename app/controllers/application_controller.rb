class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception  
  before_action :set_locale  #activation des langues, en et fr pour cette application
 
def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
#  I18n.locale = :fr 
end

def default_url_options(options={})
  { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale  }
end
=begin
def default_url_options(options = {})
  { locale: I18n.locale }.merge options
end

def set_locale
  logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"   #define local language
#  I18n.locale = extract_locale_from_accept_language_header
#  I18n.default_locale = :fr
  I18n.locale = :fr
  logger.debug "* Locale set to '#{I18n.locale}'"
end
=end
 
private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
