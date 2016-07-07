class IndicatorsController < ApplicationController
    load_and_authorize_resource
    def new
        @indicator = Indicator.new
    end
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
    def index
        @indicator = Indicator.accessible_by(current_ability).where(language: I18n.locale).order(:topic , :id1).all
    end
    def show
        @indicator = Indicator.find(params[:id])
    end    
    
    private
    def indicator_params
      params.require(:indicator).permit(:id1)
    end
end
