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
  
  
  
  def self.mail_answer
    User.all.each do |u|
      @pair=Pair.where("user1_id = ? OR user2_id = ?", u.id, u.id).first
      @round=@pair.Rounds.where(:round_date => Time.now.midnight).first
      @question=@round.question
      @partner=Pair.partner(u.id)
      
      if @round.answer.where(:user_id => @partner.id).first.nil?
         @partner_answer = "You must answer today's question to see  #{@partner.first_name} answered"
       else
         @partner_answer = @round.answer.where(:user_id => @partner.id).first
       end
      
      QuestionsMailer.pair_answered(u,@pair, @round, @question, @partner).deliver
    end
  end
  
  
  
  def pair
    Pair.where("user1_id = ? OR user2_id = ?", self.id, self.id).first
  end
  

end
