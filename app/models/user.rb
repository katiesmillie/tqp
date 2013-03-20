class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # belongs_to :pair  --> should this be here?
  has_many :answers
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

 
  def self.mail_question
    User.all.each do |u|
      @pair=Pair.where("user1_id = ? OR user2_id = ?", u.id, u.id).first
      @round=@pair.Rounds.where(:round_date => Time.now.midnight).first
      @question=@round.question
      @url="http://beta.thequestionproject.com/rounds/#{@round.id}"
      QuestionsMailer.daily_question(u,@round,@question,@url).deliver
    end
  end
  
  
  def self.mail_answer(user, round)
      @user=user
      @round=round
      @pair=Pair.where("user1_id = ? OR user2_id = ?", @user.id, @user.id).first
      @question=@round.question
      @partner= @pair.partner(@user.id)
      @answer=@round.answers.where(:user_id => @user.id).first
      @url="http://beta.thequestionproject.com/rounds/#{@round.id}"
      
      
      if @answer.nil?
         @display_answer = "You gotta answer the question to see what they said."
       else
         @display_answer = "#{@answer.body}"
       end
      
      NotificationsMailer.pair_answered(@user,@question,@partner,@display_answer,@url).deliver
    
  end
  
  def self.mail_comment(user, round, comment)
      @user=user
      @round=round
      @comment=comment
      @pair=Pair.where("user1_id = ? OR user2_id = ?", @user.id, @user.id).first
      @question=@round.question
      @partner= @pair.partner(@user.id)
      @url="http://beta.thequestionproject.com/rounds/#{@round.id}"
      
      NotificationsMailer.pair_commented(@user,@comment,@question,@partner,@url).deliver
    
  end
  
  
  
  
  def pair
    Pair.where("user1_id = ? OR user2_id = ?", self.id, self.id).first
  end
  

end
