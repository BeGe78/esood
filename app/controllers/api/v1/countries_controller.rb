class Api::V1::CountriesController < Api::V1::BaseController
  before_filter :authenticate_user_from_token!
  def index
    puts("Api::V1::CountriesController", current_ability.inspect)  
    countries = Country.accessible_by(current_ability).where(language: params[:language][0..1].to_sym).order(:type, :name).all
    render(json: countries, each_serializer: Api::V1::CountrySerializer, root: 'countries')
  end
end

