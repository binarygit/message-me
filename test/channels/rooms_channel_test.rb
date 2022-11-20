require "test_helper"

class RoomsChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe id: rooms(:one).id
    assert subscription.confirmed?
  end
end
