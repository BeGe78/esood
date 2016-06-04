require 'test_helper'

class StripeControllerTest < ActionController::TestCase
  test "should get webhook" do
    get :webhook
    assert_response :success
  end

end
