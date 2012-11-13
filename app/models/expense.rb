class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :household
  has_many :comments
  has_many :tags
  has_many :debts, :inverse_of => :expense

  accepts_nested_attributes_for :debts, :reject_if => :empty_Debt, :allow_destroy => true

  validates_presence_of :price, :item, :user, :household

  def empty_Debt(d)
  	d[:percentage_owed].to_f <= 0 || d[:percentage_owed].blank?
  end
end
