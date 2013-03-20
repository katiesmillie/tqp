class Invite < ActiveRecord::Base
  validates_presence_of :email, :user_id
  belongs_to :user
  attr_accessible :email, :user_id
  
  
  def self.mail_invite(email, user)
    @user=user
    @email=email
    @url="http://beta.thequestionproject.com"
    
    InvitesMailer.invited(@user,@email,@url).deliver
    
  end
  
  
  
end
