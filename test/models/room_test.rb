require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test "name should be present" do
    @message = Room.new(name: '')
    assert_not @message.valid?
  end
end
