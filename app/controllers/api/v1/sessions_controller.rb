class Api::V1::SessionsController < Devise::SessionsController
  #before_filter :authenticate_user_from_token!
  skip_before_filter :verify_authenticity_token, 
          :if => Proc.new { |c| c.request.format == 'application/json' } # CSRF token authenticity bypass
  #skip_before_filter :verify_signed_out_user, only: :destroy
  respond_to :json

  def create
    puts("begin", resource_name.inspect)  
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    render status: 200,
           json: { success: true,
                   info: 'Logged in',
                   data: { auth_token: current_user.authentication_token } }
  end

  def destroy
    warden.logout(scope: resource_name, recall: "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render status: 200,
           json: { success: true,
                   info: 'Logged out',
                   data: {} }
  end

  def failure
    render status: 401,
           json: { success: false,
                   info: 'Login Failed',
                   data: {} }
  end
end
