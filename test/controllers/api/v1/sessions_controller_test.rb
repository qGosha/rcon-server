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

  test "should send unauthorized error when credentials are incorrect" do
    post '/api/v1/login', params: { session: { email: @first_user.email, password: 'incorrect' } }
    assert_response :unauthorized
  end

  test "should log out successfully" do
    post '/api/v1/logout'
    assert_response :success
  end
end
