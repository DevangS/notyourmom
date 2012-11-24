class Expense < ActiveRecord::Base
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :household
  has_many :comments
  has_many :debts, :inverse_of => :expense
  has_one :reminder, :inverse_of => :expense

  accepts_nested_attributes_for :reminder, :reject_if => :no_date, :allow_destroy => true
  accepts_nested_attributes_for :debts, :reject_if => :empty_Debt, :allow_destroy => true

  validates_presence_of :price, :item, :user, :household

  def no_date(r)
    r[:date] == ""
  end

  def empty_Debt(d)
  	d[:percentage_owed].to_f <= 0 || d[:percentage_owed].blank?
  end
end
