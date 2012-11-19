# spec/factories/households.rb
require 'faker'

FactoryGirl.define do
  factory :household do
  	name { Faker::Company.name }
  end
  factory :invalid_household, parent: :household do
    name nil
  end
end