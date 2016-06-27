class IndicatorsController < ApplicationController
    require 'world_bank'
    def new
        @indicator = Indicator.new
    end
    def create
        #       English 
        @indicator = Indicator.new(indicator_params)
        @id1 = params[:indicator][:id1]
        @language = params[:indicator][:language]
        @results = WorldBank::Indicator.find(@id1).language(@language).fetch
        @indicator.id1 = @results.raw.values_at("id")[0]
        @indicator.name = @results.raw.values_at("name")[0]
        @indicator.note = @results.raw.values_at("sourceNote")[0]
        @indicator.language = @language
        @indicator.source = @results.raw.values_at("source")[0].values_at("value")[0]
        @indicator.topic = @results.raw.values_at("topics")[0][0].values_at("value")[0]
        @indicator.save
   
        render plain: @indicator.inspect        
    end
    def index
        @indicator = Indicator.all
    end
    def show
        @indicator = Indicator.find(@id1)
    end    
    
    private
    def indicator_params
      params.require(:indicator).permit(:id1)
    end
end
