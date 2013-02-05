desc "Emails a daily question to every user"
task :email_question => :environment do
  User.mail_question
end
