class Household < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users

  validates_presence_of :grp_name
end
