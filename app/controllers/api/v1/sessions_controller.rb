# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# API for the sessions controller for create and destroy actions.
class Api::V1::SessionsController < Devise::SessionsController
    
  #before_filter :authenticate_user_from_token!
  skip_before_filter :verify_authenticity_token, 
          :if => Proc.new { |c| c.request.format == 'application/json' } # CSRF token authenticity bypass
  #skip_before_filter :verify_signed_out_user, only: :destroy
  respond_to :json
  # Interface for the create action with JSON format.
  # @return an authentification token kept by the android app
  # @rest_url POST (/users/sign_in(.:format)
  def create
    puts("begin", resource_name.inspect)  
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    render status: 200,
           json: { success: true,
                   info: 'Logged in',
                   data: { auth_token: current_user.authentication_token } }
  end
  # Interface for the index action with JSON format.
  # @return destroy the authentification token
  # @rest_url DELETE (/users/sign_out(.:format)
  def destroy
    warden.logout(scope: resource_name, recall: "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render status: 200,
           json: { success: true,
                   info: 'Logged out',
                   data: {} }
  end
  # 
  # @return login error message
  def failure
    render status: 401,
           json: { success: false,
                   info: 'Login Failed',
                   data: {} }
  end
end
