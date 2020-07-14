# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# API for the countries controller for index action.
class Api::V1::CountriesController < Api::V1::BaseController
    
  before_action :authenticate_user_from_token!
  # Interface for the index action with JSON format.
  # @return [country_serializer.rb] with country id1 and name needed by the android app
  # @rest_url GET (/api/v1/users(.:format)
  def index
    puts("Api::V1::CountriesController", current_ability.inspect)  
    countries = Country.accessible_by(current_ability).where(language: params[:language][0..1].to_sym).order(:type, :name).all
    render(json: countries, each_serializer: Api::V1::CountrySerializer, root: 'countries')
  end
end

