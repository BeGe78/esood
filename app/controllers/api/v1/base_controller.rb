# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# base controller for the API's controllers
class Api::V1::BaseController < ApplicationController
    
  protect_from_forgery with: :null_session
  before_action :destroy_session
  # destroy the session for the API's controllers
  def destroy_session
    request.session_options[:skip] = true
  end
end
