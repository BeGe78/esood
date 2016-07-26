# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Handles the {Plan **Plan model**} used by stripe for recurring billing.  
# Only accessible to users with *admin* role.
# The routes of this controller support localization but the web pages are not translated as it is used only by admin. 
# {PlansControllerTest Corresponding tests:}   
#![Class Diagram](diagram/plans_controller_diagram.png)
class PlansController < ApplicationController
  load_and_authorize_resource
  # Asks for new plan
  # @return [new.html.erb] the new web page
  # @rest_url GET(/:locale)/plans/new(.:format)
  # @path new_plan
  def new    
  end
  # Displays plans list with bootstrap table sortable format
  # @return [index.html.erb] the index web page
  # @rest_url GET(/:locale)/plans(.:format)
  # @path plans
  def index
    @plans = Plan.all
  end
  # Displays the plan 
  # @return [show.html.erb] the show web page. 
  # @rest_url GET(/:locale)/plans/:id(.:format)
  # @path plan 
  def show
  end
  # Displays the plan to be modified
  # @return [edit.html.erb] the edit web page
  # @rest_url GET(/:locale)/plans/:id/edit(.:format)
  # @path edit_plan
  def edit
  end
  # Save the new plan in the database
  # @return [index.html.erb] the index web page if successfull
  # @return [new.html.erb] the new web page if unsuccessfull
  # @rest_url POST(/:locale)/plans(.:format)
  def create
      if @plan.save
        redirect_to @plan, notice: 'Plan was successfully created.'
      else
        render :new
      end
  end
  # Update the plan in the database
  # @return [index.html.erb] the index web page if successfull
  # @return [edit.html.erb] the edit web page if unsuccessfull
  # @rest_url PUT (/:locale)/plans/:id(.:format)
  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: 'Plan was successfully updated.'
    else
      render :edit
    end
  end
  # Delete the plan from the database
  # @return [index.html.erb] the index web page
  # @rest_url DELETE(/:locale)/plans/:id(.:format)
  def destroy
    @plan.destroy
          redirect_to plans_url, notice: 'Plan was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:stripe_id, :name, :amount, :interval)
    end
end
