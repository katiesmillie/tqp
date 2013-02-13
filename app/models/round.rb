class Round < ActiveRecord::Base
  validates_presence_of :pair_id, :question_id
   belongs_to :pair
   belongs_to :question
   has_many :answers
   attr_accessible :pair_id, :question_id
end
