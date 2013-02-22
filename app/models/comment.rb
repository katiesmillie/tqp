class Comment < ActiveRecord::Base
  validates_presence_of :body, :author_id, :round_id
  belongs_to :round
  belongs_to :author, :class_name => "User" 
  attr_accessible :body, :author_id, :round_id
end
