# spec/factories/expenses.rb
require 'faker'

FactoryGirl.define do
  factory :expense do
    price "100"
   	item "Food"
   	user
  end
end