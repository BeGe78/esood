# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# API for the selectors controller for create action.

class Api::V1::SelectorsController < SelectorsController
    
  before_filter :authenticate_user_from_token!
  protect_from_forgery except: :create # API    
  respond_to :json  
  # Interface for the create action with JSON format.
  # @return [selector_serializer.rb] with all the variables needed by the android app
  # @rest_url POST (/api/v1/selectors(.:format)
  def create
    I18n.locale = params[:language][0..1].to_sym
    super
    puts("s1", @s1)
    render json: { data: @s1, title: @title, same_scale: @same_scale, nbticks: @nbticks,
                   legend1: @legend1, legend2: @legend2,
                   highvalue: @highvalue, lowvalue: @lowvalue,
                   highvalue2: @highvalue2, lowvalue2: @lowvalue2, 
                   unit: @unit, unit2: @unit2,
                   label_format: @label_format, label_format2: @label_format2,
                   mean1: number_with_precision(@mean1.to_ruby, precision: @precision),
                   mean2: number_with_precision(@mean2.to_ruby, precision: @precision),
                   coeflm1: number_with_precision(@coeflm1[1], precision: @precision),
                   coeflm2: number_with_precision(@coeflm2[1], precision: @precision),
                   coeflm3_1: number_with_precision(@coeflm3_1.to_ruby, precision: @precision),
                   coeflm3_2: number_with_precision(@coeflm3_2.to_ruby, precision: @precision),
                   meanrate1: number_to_percentage(@meanrate1, precision: @precision),
                   meanrate2: number_to_percentage(@meanrate2, precision: @precision),
                   cor: number_with_precision(@cor.to_ruby, precision: @precision)
                 }, each_serializer: Api::V1::SelectorSerializer
  end
  # lists the permitted parameters for the API
  def selector_params
    params.permit(:form_switch, :year_begin, :year_end, :format,
                  :fake_indicator, :fake_indicator2, :fake_country1,
                  :fake_country2) # API
  end
end
