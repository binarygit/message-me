require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  def setup
    @invitation = login_invitations(:one)
  end

  test "sending login invitation" do
    visit root_url
    assert_selector "h1", text: "Message Me!"
    fill_in id: "email", with: "bobby@bobby.com"
    click_button id: 'send-btn'
    assert_selector '.alert.alert-success'
  end

  test "logging in" do
    # valid url
    visit login_invitations_verify_url(@invitation.unique_hash)
    click_button "Finish Login"
    assert_selector ".alert.alert-success"
    click_button "Logout"
    assert_selector ".alert.alert-success"

    # invalid url
    visit login_invitations_verify_url('fake_hash')
    assert_no_selector 'button'
  end
end
