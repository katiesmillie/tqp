class Question < ActiveRecord::Base
  validates_presence_of :body
  has_many :answers
  attr_accessible :body, :category, :author_id
end
