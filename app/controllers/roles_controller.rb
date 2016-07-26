# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Handles the {Role **Role model**} used by devise and cancancan gems.  
# Only accessible to users with *admin* role.
# The routes of this controller support localization but the web pages are not translated as it is used only by admin.  
# {RolesControllerTest Corresponding tests:}   
#![Class Diagram](diagram/roles_controller_diagram.png)
class RolesController < ApplicationController
  load_and_authorize_resource
  # Asks for new role
  # @return [new.html.erb] the new web page
  # @rest_url GET(/:locale)/roles/new(.:format)
  # @path new_role
  def new    
  end
  # Displays roles list with bootstrap table sortable format
  # @return [index.html.erb] the index web page
  # @rest_url GET(/:locale)/roles(.:format)
  # @path roles
  def index
    @roles = Role.all
  end
  # Displays the role and the users associated with it.
  # @return [show.html.erb] the show web page. 
  # @rest_url GET(/:locale)/roles/:id(.:format)
  # @path role  
  def show
    if @role.users.length == 0 
      @associated_users = "None"
    else
      @associated_users = @role.users.map(&:name).join(", ")
    end
  end
  # Displays the role to be modified
  # @return [edit.html.erb] the edit web page
  # @rest_url GET(/:locale)/roles/:id/edit(.:format)
  # @path edit_role  
  def edit
  end
  # Save the new role in the database
  # @return [index.html.erb] the index web page if successfull
  # @return [new.html.erb] the new web page if unsuccessfull
  # @rest_url POST(/:locale)/roles(.:format)
  def create
    if @role.save
      redirect_to @role, notice: 'Role was successfully created.'
    else
      render :new
    end
  end
  # Update the role in the database
  # @return [index.html.erb] the index web page if successfull
  # @return [edit.html.erb] the edit web page if unsuccessfull
  # @rest_url PUT (/:locale)/roles/:id(.:format)  
  def update
      if @role.update(role_params)
        redirect_to @role, notice: 'Role was successfully updated.'
      else
        render :edit
      end
  end
  # Delete the role from the database
  # @return [index.html.erb] the index web page
  # @rest_url DELETE(/:locale)/roles/:id(.:format)  
  def destroy
    @role.destroy
          redirect_to roles_url, notice: 'Role was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.  
    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :description)
    end
end
