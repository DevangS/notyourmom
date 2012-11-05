class User < ActiveRecord::Base
  belongs_to :household
  has_many :expenses
  has_many :debts

  def join_household=(house_id)
    self.household_id = house_id
  end

  def leave_household
    self.household_id = nil
  end

end
