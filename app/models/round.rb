class Round < ActiveRecord::Base
  validates_presence_of :question_id, :round_date
   belongs_to :pair
   belongs_to :question
   belongs_to :user
   has_many :answers
   has_many :comments
   attr_accessible :pair_id, :user_id, :question_id, :round_date
   
   
   def self.recent
     order("round_date DESC").where("round_date <= ?", Time.now)
   end
   
   def self.recent_minus_day
     order("round_date DESC").where("round_date <= ?", 1.day.ago.midnight)
   end
   
end
