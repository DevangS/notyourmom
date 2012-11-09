# spec/factories/comments.rb
require 'faker'

FactoryGirl.define do
  factory :comment do
    user
    expense
    comment { Faker::Lorem.word }
  end
end