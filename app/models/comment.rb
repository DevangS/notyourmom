class Comment < ActiveRecord::Base
  belongs_to :expense
  belongs_to :user

  validates_presence_of :comment, :expense, :user
end
