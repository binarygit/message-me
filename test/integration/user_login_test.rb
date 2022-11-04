require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:avi)
  end

  test "login invitation is not created when email is blank" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'

    assert_no_difference "LoginInvitation.count" do
      post '/login_invite', params: { email: "" }
    end

    assert_response :redirect
    follow_redirect!
    assert_template 'static_pages/home'

    assert flash[:danger]
  end

  test "a login invitation is created with email" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'

    assert_enqueued_emails 1 do
      assert_difference "LoginInvitation.count" do
        post '/login_invite', params: { email: @user.email }
      end
    end

    assert_response :redirect
    follow_redirect!
    assert_template 'static_pages/home'

    assert flash[:success]
  end
end
