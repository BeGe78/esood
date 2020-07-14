# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# API for the indicators controller for index action.
class Api::V1::IndicatorsController < Api::V1::BaseController
    
  before_action :authenticate_user_from_token!
  # Interface for the index action with JSON format.
  # @return [indicator_serializer.rb] with indicator id1 and name needed by the android app
  # @rest_url GET (/api/v1/indicators(.:format)
  def index
    indicators = Indicator.accessible_by(current_ability).where(language: params[:language][0..1].to_sym).order(:topic, :id1).all
    render(json: indicators, each_serializer: Api::V1::IndicatorSerializer, root: 'indicators')
  end
end
