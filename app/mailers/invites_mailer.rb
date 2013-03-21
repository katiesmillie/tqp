class InvitesMailer < ActionMailer::Base
  default from: "hello@thequestionproject.com"
  
  def invite_partner(user, email, message, display_message, url)
    @user_first=user.first_name
    @user_last=user.last_name
    @email = email
    @message = message
    @display_message = display_message
    @url = url
    mail(:to => email, :subject => "Your friend #{@user_first} wants to be your partner on The Question Project")
  end
  
  
  def invite_share(user, email, message, display_message, url)
    @user_first=user.first_name
    @user_last=user.last_name
    @email = email
    @message = message
    @display_message = display_message
    @url = url
    mail(:to => email, :subject => "Your friend #{@user_first} wants you to try The Question Project")
  end
  
  
  
end
