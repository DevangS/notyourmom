# spec/factories/debts.rb
require 'faker'

FactoryGirl.define do
  factory :debt do
  	percentage_owed ([*0..100] - [0]).sample
    expense
    user
  end
  factory :invalid_debt, parent: :debt do
    user nil
  end
end