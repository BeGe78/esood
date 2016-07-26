# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Handles the {Country **Country model**} as defined by for the WorldBank database.  
# Only writable by users with *admin* role. Readable by anyone but with limitation (visible=Y) for not logged users.  
# This controller support full localization (routes, fields and data).  
# {CountriesControllerTest Corresponding tests:}   
#![Class Diagram](diagram/countries_controller_diagram.png)
class CountriesController < ApplicationController  #reserved to admin. Let create and list countries
  load_and_authorize_resource
  # Asks for new country (country code and language)
  # @return [new.html.erb] the new web page
  # @rest_url GET(/:locale)/countries/new(.:format)
  # @path new_country
  def new
    @country = Country.new
  end
  # Fetch the country from WorldBank and save the new country in the database. Error messages are rescued to flash notices.
  # @return [index.html.erb] the index web page if successfull
  # @return [new.html.erb] the new web page if unsuccessfull
  # @rest_url POST(/:locale)/countries(.:format)
  def create
    @country = Country.new(country_params)
    @id1 = params[:country][:id1]
    @language = params[:country][:language]
    begin            # get worldbank data
    @results = WorldBank::Country.find(@id1).language(@language).fetch #get WorldBank country by id and language
    @country.id1 = @results.raw["id"]
    @country.name = @results.raw["name"]
    @country.iso2code = @results.raw["iso2Code"]
    @country.code = @results.raw["id"]
    @country.type = "Pays" if @language == 'fr'
    @country.type = "Country" if @language == 'en'
    @country.language = @language
    @country.save
    rescue Exception => e
    flash[:notice] = "Error creating country"
    redirect_to new_country_path and return
    end
    render plain: @country.inspect        
  end
  # Displays countries list with bootstrap table sortable format and filtered by ability and language. 
  # List is filtered by language and by ability
  # @return [index.html.erb] the index web page
  # @rest_url GET(/:locale)/countries(.:format)
  # @path countries
  def index
    @country = Country.accessible_by(current_ability).where(language: I18n.locale).order(:type , :name).all
  end
  # Displays the country 
  # @return [show.html.erb] the show web page. 
  # @rest_url GET(/:locale)/countries/:id(.:format)
  # @path country
  def show
    @country = Country.find(params[:id])
  end    
  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def country_params
    params.require(:country).permit(:id1)
  end       
end
    
