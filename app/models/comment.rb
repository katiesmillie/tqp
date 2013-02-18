class Comment < ActiveRecord::Base
  validates_presence_of :body, :author_id, :round_id
  belongs_to :round
  attr_accessible :body, :author_id, :round_id
end
