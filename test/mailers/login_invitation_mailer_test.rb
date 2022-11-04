require "test_helper"

class LoginInvitationMailerTest < ActionMailer::TestCase
  test "login invitation" do
    invitation = login_invitations(:one)
    email = LoginInvitationMailer.login_invitation(invitation)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["from@example.com"], email.from
    assert_equal [invitation.email], email.to
    assert_equal "[Message me!] Login via link", email.subject

    assert_match "Message me!", email.body.encoded
    # TODO test whether the email contains a link to the root
    # and a link to the verify action
  end
end
