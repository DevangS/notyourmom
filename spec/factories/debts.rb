# spec/factories/debts.rb
require 'faker'

FactoryGirl.define do
  factory :debt do
    expense
    user
  end
end