class InvitesMailer < ActionMailer::Base
  default from: "invite@thequestionproject.com"


  
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
    mail(:to => email, :bcc => "katiesmillie@gmail.com", :subject => "Your friend #{@user_first} wants you to try The Question Project")
  end
  
  
  def invite_accepted(user, partner, pair, round, url, question)
      @user=user
      @partner=partner
      @pair=pair
      @round=round
      @url=url
      @question=question
      mail(:to => @partner.email, :bcc => "katiesmillie@gmail.com", :subject => "#{@user.first_name} is your new partner at The Question Project")
    
  end
  
  def reminder_invite(user, email, message, display_message, url)
    @user_first=user.first_name
    @user_last=user.last_name
    @email = email
    @message = message
    @display_message = display_message
    @url = url
    mail(:to => email, :bcc => "katiesmillie@gmail.com", :subject => "Don't forget! Your friend #{@user_first} wants you to try The Question Project")
  end

  
end
