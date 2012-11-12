class Debt < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense

  validates_presence_of :user
  validates_numericality_of :percentage_owed, :greater_than => 0, :less_than_or_equal_to => 100
end
