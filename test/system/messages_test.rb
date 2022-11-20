require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  def setup
    @invitation = login_invitations(:one)
  end


  test "creating a message" do
    visit login_invitations_verify_url(@invitation.unique_hash)
    click_button "Finish Login"
    assert_selector "input", id: "message_description"
    fill_in id: "message_description", with: "Hello World!"
    click_button "Send message"
    last_message = Message.last
    assert_selector "div", id: dom_id(last_message)
  end
end
