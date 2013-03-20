class InvitesMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def invited(user, email, url)
    @user = user.first_name
    @email = email
    @url = url
    mail(:to => email, :subject => "Your friend #{@user} invited you to The Question Project")
  end
  
  
  
end
