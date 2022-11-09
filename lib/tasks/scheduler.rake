desc "This task is called by the Heroku scheduler add-on"

task :delete_login_invitations => :environment do
  puts "This app deletes all login invitations at the end of the day"
  puts "Deleting LoginInvitations"
  LoginInvitation.delete_all
  puts "Completed deleting old LoginInvitations"
end

