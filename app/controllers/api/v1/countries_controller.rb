class Api::V1::CountriesController < Api::V1::BaseController
  before_filter :authenticate_user_from_token!
  def index
    countries = Country.accessible_by(current_ability).where(language: I18n.locale).order(:type, :name).all
    render(json: countries, each_serializer: Api::V1::CountrySerializer, root: 'countries')
  end
end
