require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
  end

  test "should login successfully and receive correct user json" do
    post '/api/v1/login', params: { session: { email: @first_user.email, password: 'password' } }
    assert_response :success
    assert_equal response.body, @first_user.to_json
  end
end
