class Household < ActiveRecord::Base
  has_many :users
  has_many :expenses
  accepts_nested_attributes_for :users

  validates_presence_of :name
end
