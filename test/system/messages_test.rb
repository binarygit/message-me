require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  def setup
    login_with(login_invitations(:one))
    visit room_url(rooms(:one))
  end

  test "creating a message" do
    assert_selector "input", id: "message_description"
    fill_in id: "message_description", with: "Hello World!"
    click_button "Send message"
    last_message = Message.last
    assert_selector "div", id: dom_id(last_message)
  end

  test "creating a message in another room sends notification" do
    room_two = window_opened_by do
      open_new_window(:tab)
    end

    within_window room_two do
      visit room_url(rooms(:two))
      fill_in id: "message_description", with: "Hello from room_2!"
      click_button "Send message"
    end

    # TODO simplify this assertion
    # it's testing all of my cable_ready's behaviour
    # checking to see if the correct text is rendered
    # and if the correct classes have been attached
    assert_selector "button", id: "#{dom_id(rooms(:two), :button)}", 
      text: "#{rooms(:two).name}*", class: ["btn", "btn-warning", "operative", "pulsating"]
  end

  test "loading more messages" do
    refresh
    assert_no_selector "div", text: "Hello World!"
    click_button "Load more messages"
    assert_selector "div", text: "Hello World!"
    # A flash is displayed when there are no more
    # messages to load
    assert_no_selector ".flash"
    click_button "Load more messages"
    assert_selector ".flash"
  end

  test "loading more messages after new messages have been sent" do
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
