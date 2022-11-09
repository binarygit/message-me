require "test_helper"

class LoginInvitationMailerTest < ActionMailer::TestCase

  test "login invitation" do
    invitation = login_invitations(:one)
    email = LoginInvitationMailer.login_invitation(invitation)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["inscription4@outlook.com"], email.from
    assert_equal [invitation.email], email.to
    assert_equal "[Message me!] Login via link", email.subject

    assert_match "Message me!", email.body.encoded
    assert_match "verify-login-link", email.body.encoded
  end
end
