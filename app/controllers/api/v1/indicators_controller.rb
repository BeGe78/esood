class Api::V1::IndicatorsController < Api::V1::BaseController
  before_filter :authenticate_user_from_token!
  def index
    indicators = Indicator.accessible_by(current_ability).where(language: params[:language][0..1].to_sym).order(:topic, :id1).all
    render(json: indicators, each_serializer: Api::V1::IndicatorSerializer, root: 'indicators')
  end
end
