class Debt < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense

  validates_presence_of :expense, :user
end
