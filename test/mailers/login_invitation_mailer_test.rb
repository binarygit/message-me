require "test_helper"

class LoginInvitationMailerTest < ActionMailer::TestCase
  test "login invitation" do
    invitation = login_invitations(:one)
    email = LoginInvitationMailer.login_invitation(invitation.id)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["from@example.com"], email.from
    assert_equal [invitation.email], email.to
    assert_equal "[Message me!] Login via link", email.subject

    #assert_equal read_fixture("invite").join, email.text_part.body.to_s
    assert_equal read_fixture("invite").join, email.html_part.body.to_s
  end
end
