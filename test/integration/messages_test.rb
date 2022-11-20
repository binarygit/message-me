require 'test_helper'

class MessagesTest < ActionDispatch::IntegrationTest

  test "user can create a message" do
    post login_path, params: { invitation_id: login_invitations(:one).id }
    follow_redirect!
    assert_select "input", id: "#message_description"

    assert_difference "Message.count" do
      post messages_path, params: { message: { description: "Hello World!", room_id: Room.first.id } }
    end
  end
end
