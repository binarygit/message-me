# frozen_string_literal: true

class LoadedMessageComponent < ViewComponent::Base
  def initialize(loaded_message:)
    @loaded_message = loaded_message
  end
end
