class RolesController < ApplicationController
  load_and_authorize_resource
  def new    
  end
  
  def index
    @roles = Role.all
  end

def show
  if @role.users.length == 0        #determines the users associated with this role
    @associated_users = "None"
  else
    @associated_users = @role.users.map(&:name).join(", ")
  end
end

  def edit
  end

  def create
      if @role.save
        redirect_to @role, notice: 'Role was successfully created.'
      else
        render :new
      end
  end

  def update
      if @role.update(role_params)
        redirect_to @role, notice: 'Role was successfully updated.'
      else
        render :edit
      end
  end

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
