class Household < ActiveRecord::Base
  has_many :users
  has_many :expenses
  accepts_nested_attributes_for :users

  validates_presence_of :name

  #Get the head of this household
  def head
    User.find(self.head_id)
  end

  def head=(user)
    self.head_id = user.id
  end

  def members
    User.where(:household_id => self.id)
  end

  def expenses
    Expense.where(:household_id => self.id)
  end
end
