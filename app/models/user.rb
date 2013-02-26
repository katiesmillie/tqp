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
      @round=@pair.rounds.where(:round_date => Time.now.midnight).first
      @question=@round.question
      QuestionsMailer.daily_question(u,@question).deliver
    end
  end
  
  
  
  def self.mail_answer(user)
      @user=user
      @pair=Pair.where("user1_id = ? OR user2_id = ?", @user.id, @user.id).first
      @round=@pair.rounds.where(:round_date => Time.now.midnight).first
      @question=@round.question
      @partner= @user.pair.partner(@user.id)
      @partner_answer=@round.answers.where(:user_id => @partner.id).first
      
      if @round.answers.where(:user_id => @partner.id).first.nil?
         @display_answer = "You have to answer the question too in order to see #{@partner.first_name}'s answer"
       else
         @display_answerr = "#{@partner.first_name} said: #{@answer.body}"
       end
      
      QuestionsMailer.pair_answered(@user, @question, @partner, @display_answer).deliver
    
  end
  
  
  
  def pair
    Pair.where("user1_id = ? OR user2_id = ?", self.id, self.id).first
  end
  

end
