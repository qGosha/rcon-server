require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:test)
    log_in_as @first_user  
  end

  test "should get index" do
    get '/api/v1/users'
    assert_response :success
  end

  test "shouldn update user" do
    patch "/api/v1/users/#{@first_user.id}", params: { user: { email: 'newemail@qwerty.com' } }
    assert_response :success
  end

  test "shouldn create a new user" do
    post "/api/v1/users/", params: { user: { email: 'newemail@qwerty.com', password: '123456' } }
    assert_response :success
  end

  test "shouldn destroy a user" do
    delete "/api/v1/users/#{@first_user.id}"
    assert_response :success
  end

  # test "shouldn't let edit if not logged in" do
  #   get edit_user_path(@first_user)
  #   assert_redirected_to login_path
  #   assert flash[:danger]
  # end

  # test "shouldn't let edit other users" do
  #   log_in_as @first_user
  #   get edit_user_path(@second_user)
  #   assert_redirected_to root_path
  # end

  # test "shouldn't let update other users" do
  #   log_in_as @first_user
  #   patch user_path(@second_user), params: { user: @second_user }
  #   assert_redirected_to root_path
  # end

  # test "should redirect index when not logged in" do
  #   get users_path
  #   assert_redirected_to login_url
  # end

  # test "should redirect destroy when not logged in" do
  #   assert_no_difference 'User.count' do
  #     delete user_path(@first_user)
  #   end
  #   assert_redirected_to login_url
  # end

  # test "should redirect destroy when logged in as a non-admin" do
  #   log_in_as @second_user
  #   assert_no_difference 'User.count' do
  #     delete user_path(@first_user)
  #   end
  #   assert_redirected_to root_path
  # end

  # test "should delete a user on destroy" do
  #   log_in_as @first_user
  #   assert_difference 'User.count', -1 do
  #     delete user_path(@second_user)
  #   end
  # end

  # test "should redirect following when not logged in" do
  #   get following_user_path(@first_user)
  #   assert_redirected_to login_url
  # end

  # test "should redirect followers when not logged in" do
  #   get followers_user_path(@first_user)
  #   assert_redirected_to login_url
  # end

end
