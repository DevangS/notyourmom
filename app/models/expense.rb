class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :household
  has_many :comments
  has_many :tags
  has_many :debts

  accepts_nested_attributes_for :debts, :allow_destroy => true

  validates :price, presence: true
  validates :item, presence: true
end
