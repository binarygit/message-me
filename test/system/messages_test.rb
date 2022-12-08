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

  test "loading more messages" do
    visit login_invitations_verify_url(@invitation.unique_hash)
    click_button "Finish Login"
    assert_no_selector "div", text: "Hello World!"
    click_button "Load more messages"
    assert_selector "div", text: "Hello World!"
    # A flash is displayed when there are no more
    # messages to load

    # Need to wait here, for the Login flash
    # to disappear...urgh
    # TODO find a way to reload the page
    assert_no_selector ".flash", wait: 6
    click_button "Load more messages"
    assert_selector ".flash"
  end

  test "loading more messages after new messages have been sent" do
    visit login_invitations_verify_url(@invitation.unique_hash)
    click_button "Finish Login"
    10.times do |i|
      fill_in id: "message_description", with: "new_message_#{i}"
      click_button "Send message"
    end
    message = Message.find_by_description(messages(:message_0).description)
    assert_selector "div", id: dom_id(message), count: 1
    click_button "Load more messages"
    assert_selector "div", id: dom_id(message), count: 1
    assert_selector "div", text: "Hello World!"
  end
end
