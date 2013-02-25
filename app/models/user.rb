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
      @pair=Pair.where("user1_id = ? OR user2_id = ?", self.id, self.id).first
      @round=@pair.Rounds.where :round_date => Time.now.midnight
      @question=@round.question
      QuestionsMailer.daily_question(u,@question).deliver
    end
  end
  
  def pair
    Pair.where("user1_id = ? OR user2_id = ?", self.id, self.id).first
  end
  

end
