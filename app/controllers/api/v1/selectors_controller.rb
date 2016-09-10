class Api::V1::SelectorsController < SelectorsController
  before_filter :authenticate_user_from_token!
  protect_from_forgery except: :create # API    
  respond_to :json  
  def create
    super
    puts("s1", @s1)
    render json: { data: @s1, title: @title, highvalue: @highvalue, lowvalue: @lowvalue, nbticks: @nbticks, unit: @unit }, each_serializer: Api::V1::SelectorSerializer
  end
  def selector_params
    params.permit(:form_switch, :year_begin, :year_end, :format,
                  :fake_indicator, :fake_indicator2, :fake_country1,
                  :fake_country2) # API
  end
end
