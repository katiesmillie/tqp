class Answer < ActiveRecord::Base
  validates_presence_of :body, :question_id, :user_id, :round_id
  belongs_to :question
  belongs_to :user
  attr_accessible :body, :question_id, :user_id, :round_id
  
end
