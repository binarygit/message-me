# frozen_string_literal: true

class UserComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  private

  def email
    @email = @user.email
  end
end
