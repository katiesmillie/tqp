class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body
  has_many :answers
  
  def self.mail_question
    User.all.each do |u|
      # @question=Question.scoped.sample
      @pair=u.pair
      @round=Round.create :question_id => @question.id, :pair_id => @pair.id
      QuestionsMailer.daily_question(u,@question).deliver
    end
  end
  
  def pair
    Pair.where("user1_id = ? OR user2_id = ?", current_user.id, current_user.id).first
  end
  
#trying to use SQL to get user's first name to display on round#show next to comments   
  def comment_author
    User.first_name from Users inner join on (Users.user_id = Comments.author_id) 
  end

end
