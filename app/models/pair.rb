class Pair < ActiveRecord::Base
  validates_presence_of :user1_id, :user2_id
  belongs_to :user1, :class_name => "User"
  belongs_to :user2, :class_name => "User"
  has_many :rounds
  attr_accessible :user1_id, :user2_id
end
