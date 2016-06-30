class CountriesController < ApplicationController  #reserved to admin. Let create and list countries
    def new
        @country = Country.new
    end 
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
    def index
        @country = Country.all    
    end    
    private
    def country_params
      params.require(:country).permit(:id1)
    end       
end
