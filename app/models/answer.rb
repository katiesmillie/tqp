class Answer < ActiveRecord::Base
  validates_presence_of :body, :question_id
  belongs_to :question
  attr_accessible :body, :question_id
  
end
