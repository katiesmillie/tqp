class Answer < ActiveRecord::Base
  validates_presence_of :body, :question_id, :user_id, :round_id
  validates :user_id, :uniqueness => { :scope => [:round_id, :question_id]}
  # validates_each :user_id do |record, attr, value|
  #     round=record.round
  #     pair=round.pair
  #     record.errors.add(attr, 'user must be in round') unless pair.user1_id == value || pair.user2_id == value
  #   end
  belongs_to :question
  belongs_to :user
  belongs_to :round
  attr_accessible :body, :question_id, :user_id, :round_id
  
end
