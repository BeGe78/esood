class PlansController < ApplicationController
  load_and_authorize_resource
  def new    
  end
  
  def index
    @plans = Plan.all
  end

  def show
  end

  def edit
  end

  def create
      if @plan.save
        redirect_to @plan, notice: 'Plan was successfully created.'
      else
        render :new
      end
  end

  def update
      if @plan.update(plan_params)
        redirect_to @plan, notice: 'Plan was successfully updated.'
      else
        render :edit
      end
  end

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
