class User < ActiveRecord::Base
  belongs_to :household
  has_many :expenses
  has_many :debts

  def full_name
    [firstName, lastName].join(' ')
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.firstName = split.first
    self.lastName = split.last
  end

  def join_household=(house_id)
    self.household_id = house_id
  end

  def leave_household
    self.household_id = nil
  end

end
