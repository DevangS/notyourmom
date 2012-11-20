class Debt < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense

  validates_presence_of :user, :expense

  validates_numericality_of :percentage_owed, :greater_than => 0, :less_than_or_equal_to => 100

  def get_share
    self.percentage_owed * self.expense.price/100
  end
end
