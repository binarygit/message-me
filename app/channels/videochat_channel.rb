class VideochatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tab_video_chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("tab_video_chat", data)
  end
end
