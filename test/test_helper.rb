ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !cookies[:user_id].blank?
  end
end

class ActionDispatch::SystemTestCase
  def login_with(invitation)
    visit login_invitations_verify_url(invitation.unique_hash)
    click_button "Finish Login"
  end
end
