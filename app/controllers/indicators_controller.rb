# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Handles **Indicator model** as defined by for the WorldBank database.  
# Only writable by users with *admin* role. Readable by anyone but with limitation (visible=Y) for not logged users.  
# This controller support full localization (routes, fields and data).  
#![Class Diagram](diagram/indicators_controller_diagram.png)
class IndicatorsController < ApplicationController
  load_and_authorize_resource
  # Asks for new indicator (indicator id and language)
  # @return [new.html.erb] the new web page
  # @rest_url GET(/:locale)/indicators/new(.:format)
  # @path new_indicator
  def new
    @indicator = Indicator.new
  end
  # Fetch the indicator from WorldBank and save the new indicator in the database. Error messages are rescued to flash notices.
  # @return [index.html.erb] the index web page if successfull
  # @return [new.html.erb] the new web page if unsuccessfull
  # @rest_url POST(/:locale)/indicators(.:format)
  def create
    @indicator = Indicator.new(indicator_params)
    @id1 = params[:indicator][:id1]
    @language = params[:indicator][:language]
    begin
    @results = WorldBank::Indicator.find(@id1).language(@language).fetch  #get WorldBank indicator by id and language
    @indicator.id1 = @results.raw["id"]
    @indicator.name = @results.raw["name"]
    @indicator.note = @results.raw["sourceNote"]
    @indicator.language = @language
    @indicator.source = @results.raw["source"]["value"]
    @indicator.topic = @results.raw["topics"].first["value"]
    @indicator.save
    rescue Exception => e
     flash[:notice] = "Error creating indicator"
     redirect_to new_indicator_path and return
    end
    render plain: @indicator.inspect        
  end
  # Displays indicators list with bootstrap table sortable format and filtered by ability and language. 
  # List is filtered by language and by ability
  # @return [index.html.erb] the index web page
  # @rest_url GET(/:locale)/indicators(.:format)
  # @path indicators
  def index
    @indicator = Indicator.accessible_by(current_ability).where(language: I18n.locale).order(:topic , :id1).all
  end
  # Displays the indicator 
  # @return [show.html.erb] the show web page. 
  # @rest_url GET(/:locale)/indicators/:id(.:format)
  # @path indicator
  def show
    @indicator = Indicator.find(params[:id])
  end
  # Displays the indicator to be modified
  # @return [edit.html.erb] the edit web page
  # @rest_url GET(/:locale)/indicators/:id/edit(.:format)
  # @path edit_indicator
  def edit
  end
  # Update the indicator in the database
  # @return [index.html.erb] the index web page if successfull
  # @return [edit.html.erb] the edit web page if unsuccessfull
  # @rest_url PUT (/:locale)/indicators/:id(.:format)
  def update
    if @indicator.update(indicator_params)
    redirect_to @indicator, notice: 'Plan was successfully updated.'
    else
    render :edit
    end
  end
  # Delete the indicator from the database
  # @return [index.html.erb] the index web page
  # @rest_url DELETE(/:locale)/indicators/:id(.:format)  
  def destroy
    @indicator.destroy
    redirect_to indicators_url, notice: 'Plan was successfully destroyed.'
  end    
    
  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def indicator_params
    params.require(:indicator).permit(:id1, :name, :language, :topic, :note, :visible)
  end
end    
