class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers
  has_many :invites
  has_many :comments, :foreign_key => :author_id
  has_many :rounds
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :image

  after_create :setup_pair_if_invited
  
 
  def self.mail_question
    User.all.each do |u|
      
      if Pair.where("user1_id = ? OR user2_id = ?", u.id, u.id).first.nil?
      else
        @pair=Pair.where("user1_id = ? OR user2_id = ?", u.id, u.id).first
        
        if @pair.rounds.where(:round_date => Time.now.midnight).first.nil?
        else
          @round=@pair.rounds.where(:round_date => Time.now.midnight).first
          @question=@round.question
          @url="http://beta.thequestionproject.com/rounds/#{@round.id}"
          QuestionsMailer.daily_question(u,@round,@question,@url).deliver 
        end
      end
    end
  end
  
  def self.daily_mail
    User.all.each do |u|
    @pair=Pair.where("user1_id = ? OR user2_id = ?", u.id, u.id).first
        
        next unless @pair
        @partner=@pair.partner(u.id)
        @answers=@partner.answers.where("created_at > ?", 1.day.ago).all
        @comments=Comment.where("created_at > ? AND author_id =?", 1.day.ago, @partner).all
        @round=@pair.rounds.where(:round_date => Time.now.midnight).first
        @rounds=@pair.rounds.recent_minus_day
         
        next unless @round
        @question=@round.question
        @url="http://beta.thequestionproject.com/rounds/#{@round.id}"
        
          @unanswered_rounds = []
          @rounds.each do |r|
            answer = r.answers.where(:user_id => u.id).first
            if !answer
              @unanswered_rounds << r  #adds item to array each time
            end
          end
        
        @last_month=Answer.where("created_at < ? AND created_at > ? AND user_id = ?", 30.days.ago, 31.days.ago, u.id).first   
        @last_week=Answer.where("created_at < ? AND created_at > ? AND user_id = ?", 7.days.ago, 8.days.ago, u.id).first
        
        QuestionsMailer.daily_email(u,@round,@rounds,@unanswered_rounds,@question,@partner,@answers,@comments,@url,@last_month,@last_week).deliver 
    end
  end
    
  def self.mail_answer(user, round)
      @user=user
      @round=round
      @pair=Pair.where("user1_id = ? OR user2_id = ?", @user.id, @user.id).first
      @question=@round.question
      
      return unless @pair
      @partner= @pair.partner(@user.id)
      @answer=@round.answers.where(:user_id => @user.id).first
      @url="http://beta.thequestionproject.com/rounds/#{@round.id}"
      
      # if @round.answers.where(:user_id => @partner.id).first.nil?
                 # NotificationsMailer.pair_answered_hidden(@user,@question,@partner,@url).deliver
                 #               else
                 NotificationsMailer.pair_answered(@user,@question,@partner,@answer,@url).deliver
               # end
    
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
  
  def setup_pair_if_invited
      @user=User.where(:id => self.id).first
      @invite=Invite.where(:email => @user.email).first

      return unless @invite
      @partner=User.where(:id =>@invite.user_id).first
      @invite.accepted = true
      @invite.save
      return if @user.pair || @partner.pair
      @pair=Pair.create(:user1_id => @invite.user_id, :user2_id => @user.id)
      @invite.mail_accepted(@user,@partner,@pair)
        
  end
  
  def pair
    Pair.where("user1_id = ? OR user2_id = ?", self.id, self.id).first
  end

end
