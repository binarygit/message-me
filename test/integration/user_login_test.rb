require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  test "a login invitation is created" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'

    assert_difference "LoginInvitation.count" do
      post '/login_invite', params: { email: "avi@avi.com" }
    end
    assert_response :redirect
    follow_redirect!
    assert_template 'static_pages/home'
    assert_equal 'Login link has been sent to avi@avi.com', flash[:success]
  end
end
