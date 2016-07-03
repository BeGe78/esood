class UsersController < ApplicationController
  load_and_authorize_resource
  def new
  end
  def index
    @users = User.all
  end

  def show                                                     #format correctly the join date and the last_login date
      @joined_on = @user.created_at.to_formatted_s(:short)
      if @user.current_sign_in_at
        @last_login = @user.current_sign_in_at.to_formatted_s(:short)
      else
        @last_login = "never"
      end
  end

  def edit
  end

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

  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @user.destroy
        redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :description)
    end
end
