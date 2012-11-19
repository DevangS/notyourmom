# spec/factories/expenses.rb
require 'faker'

FactoryGirl.define do
  factory :expense do
    price "100"
   	item "Food"
   	user
   	household
  end
  factory :invalid_expense, parent: :expense do
    user nil
  end
end