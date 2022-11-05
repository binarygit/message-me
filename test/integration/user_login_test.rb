require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:avi)
    @invitation = login_invitations(:one)
  end

  test "login invitation is not created when email is blank" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'

    assert_no_difference "LoginInvitation.count" do
      post login_invitations_path, params: { email: "" }
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
        post login_invitations_path, params: { email: @user.email }
      end
    end

    assert_response :redirect
    follow_redirect!
    assert_template 'static_pages/home'

    assert flash[:success]
  end

  test "invalid login invitation can not be used to login" do
    get login_invitations_verify_path("invalid")
    assert_response :success

    assert_select 'h1', "Sorry, that login link is too old."
    assert_select "button", count: 0
  end

  test "valid login invitation can be used to login" do
    get login_invitations_verify_path(@invitation.unique_hash)
    assert_response :success
    assert_template 'login_invitations/verify'

    assert_select 'h1', "Continue to Message me!"
    assert_select 'p', "logging in as #{@invitation.email}"
    assert_select "button", "Finish Login"

    # It creates the user if the user doesn't exist
    assert_difference "User.count" do
      # It deletes the invitation once logged in
      assert_difference "LoginInvitation.count", -1 do
        post login_path, params: { invitation_id: @invitation.id }
      end
    end

    assert_response :redirect
    follow_redirect!
    assert is_logged_in?
    assert_template 'static_pages/home'
    assert flash[:success]
  end

  test "logging in doesn't create new user if user already exists" do
    invitation = login_invitations(:two)
    assert_no_difference "User.count" do
      post login_path, params: { invitation_id: invitation.id }
    end

    assert is_logged_in?
  end
end
