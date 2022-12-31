# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(message:, message_type:)
    @message = message
    @message_type = message_type
  end

end
