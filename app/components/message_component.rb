# frozen_string_literal: true

class MessageComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end

  private

  def author
    @message.author.email
  end

  def description
    @message.description
  end
end
