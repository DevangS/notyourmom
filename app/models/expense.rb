class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :household
  has_many :comments
  has_many :tags
  has_many :debts

  accepts_nested_attributes_for :debts, :reject_if => :empty_Debt, :allow_destroy => true

  validates :price, presence: true
  validates :item, presence: true

  def empty_Debt(d)
  	d[:percentage_owed] == 0.0 || d[:percentage_owed].blank?
  end
end
