class CountriesController < ApplicationController
    require 'world_bank'
    def new
        @country = Country.new
    end 
    def create
        @country = Country.new(country_params)
        @id1 = params[:country].values[0]
        @results = WorldBank::Country.find(@id1).language('fr').fetch
        @country.id1 = @results.raw.values_at("id")[0]
        @country.name = @results.raw.values_at("name")[0]
        @country.iso2code = @results.raw.values_at("iso2Code")[0]
        @country.code = @results.raw.values_at("id")[0]
        @country.type = "Pays"
        @country.language = "fr"
        @country.save
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
