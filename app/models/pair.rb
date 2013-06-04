class Pair < ActiveRecord::Base
  validates_presence_of :user1_id, :user2_id
  belongs_to :user1, :class_name => "User"
  belongs_to :user2, :class_name => "User"
  has_many :rounds
  attr_accessible :user1_id, :user2_id
  
  # after_create :create_round
  
  def partner(user_id)
    if user_id == self.user1_id  # checking equality, comparing ids is faster then checking the user
      user2  # assigning is one equal sign, don't need to include partner =, ruby returns the last thing
    else
      user1
    end
  end

    
  def self.auto_create
    Pair.all.each do |p|
      @recent_rounds=Round.where("created_at > ? AND pair_id = ?", 30.days.ago.midnight, p.id).all

      @recent_question_ids=[]
      @recent_rounds.each do |r|
        @recent_question_ids << r.question.id
      end
      
      @question=Question.where(["id NOT IN (?)", @recent_question_ids]).sample
    
      if p.rounds.where(:round_date => Time.now.midnight).first.nil?
           @round=Round.create :question_id => @question.id, :pair_id => p.id, :round_date => Time.now.midnight
      end
           
    end
  end
  
  
  def create_round
      @pair=Pair.where(:id => self.id).first
      @question=Question.find(5)
      @round=Round.create :question_id => @question.id, :pair_id => @pair.id, :round_date => Time.now.midnight
  end
  
      
end
