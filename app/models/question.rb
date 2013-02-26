class Question < ActiveRecord::Base
  validates_presence_of :body
  has_many :answers
  belongs_to :round
  attr_accessible :body, :category, :author_id
end
