require "test_helper"

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = rooms(:one)
  end

  test "name should be present" do
    @room.name = ''
    assert_not @room.valid?
  end

  test "deletes messages when room is deleted" do
    assert_equal 20, Message.count
    assert_not_nil @room.messages
    @room.destroy
    assert_equal 0, Message.count
  end
end
