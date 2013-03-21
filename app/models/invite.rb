class Invite < ActiveRecord::Base
  validates_presence_of :email, :user_id
  belongs_to :user
  attr_accessible :email, :user_id, :message
  
  
  def self.mail_invite(user, email, message)
    @user=user
    @email=email
    @message=message
    
    if message.to_s == ''
      @display_message= ''
    else
      @display_message="#{@user.first_name} left you a message:"
    end
    
    @url="http://beta.thequestionproject.com"
   
    InvitesMailer.invite_partner(@user,@email,@message,@display_message, @url).deliver
    
  end
  
  def self.mail_share(user, email, message)
    @user=user
    @email=email
    @message=message
    
    if message.to_s == ''
      @display_message= ''
    else
      @display_message="#{@user.first_name} left you a message:"
    end
    
    @url="http://beta.thequestionproject.com"
   
    InvitesMailer.invite_share(@user,@email,@message,@display_message, @url).deliver
    
  end
    
  
end
