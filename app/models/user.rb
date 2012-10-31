class User < ActiveRecord::Base
  belongs_to :household
  has_many :expenses
  has_many :debts
end
