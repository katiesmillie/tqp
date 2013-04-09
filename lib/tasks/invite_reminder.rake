desc "Sends a reminder to people who haven't accepted an invite"
task :invite_reminder => :environment do
  Invite.mail_reminder
end
