class Question < ActiveRecord::Base
  validates_presence_of :body
  has_many :answers
  has_many :rounds
  belongs_to :author, :class_name => "User"
  attr_accessible :body, :category, :author_id
end
