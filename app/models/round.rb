class Round < ActiveRecord::Base
  validates_presence_of :pair_id, :question_id, :round_date
   belongs_to :pair
   belongs_to :question
   has_many :answers
   has_many :comments
   attr_accessible :pair_id, :question_id, :round_date
   
   def current_pair
   end
   
end
