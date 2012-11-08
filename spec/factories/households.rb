# spec/factories/households.rb
require 'faker'

FactoryGirl.define do
  factory :household do
  	name { Faker::Company.name }
  end
end