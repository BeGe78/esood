# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Handles the {User **User model**} which is central for user management due to links with devise and stripe.     
# Only visible by users with *admin* role.  
# This controller support localization for routes.  
# {UsersControllerTest Corresponding tests:}   
#![Class Diagram](diagram/users_controller_diagram.png)
class UsersController < ApplicationController
  load_and_authorize_resource
  # Asks for new user. Normally, users are not created this way.  
  # @return [new.html.erb] the new web page
  # @rest_url GET(/:locale)/admin/users/new(.:format)
  # @path new_user
  def new
  end
  # Displays users list with bootstrap table sortable format. 
  # @return [index.html.erb] the index web page
  # @rest_url GET(/:locale)/admin/users(.:format)
  # @path users
  def index
    @users = User.all
  end
  # Displays the user 
  # @return [show.html.erb] the show web page. 
  # @rest_url GET(/:locale)/admin/users/:id(.:format)
  # @path user
  def show                                                     #format correctly the join date and the last_login date
      @joined_on = @user.created_at.to_formatted_s(:short)
      if @user.current_sign_in_at
        @last_login = @user.current_sign_in_at.to_formatted_s(:short)
      else
        @last_login = "never"
      end
  end
  # Displays the user to be modified
  # @return [edit.html.erb] the edit web page
  # @rest_url GET(/:locale)/admin/users/:id/edit(.:format)
  # @path edit_user
  def edit
  end
  # Save the new user in the database. Rescue error message with flash.  
  # @return [index.html.erb] the index web page if successfull
  # @return [new.html.erb] the new web page if unsuccessfull
  # @rest_url POST(/:locale)/admin/users(.:format)
  def create      
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
       end
    end
  rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_user_path
  end
  # Update the user in the database
  # @return [index.html.erb] the index web page if successfull
  # @return [edit.html.erb] the edit web page if unsuccessfull
  # @rest_url PUT (/:locale)/admin/users/:id(.:format)
  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end
  # Delete the user from the database
  # @return [index.html.erb] the index web page
  # @rest_url DELETE(/:locale)/admin/users/:id(.:format)
  def destroy
    @user.destroy
        redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :role_id, :plan_id, :password, :password_confirmation)
    end
end
