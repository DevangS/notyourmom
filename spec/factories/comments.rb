# spec/factories/comments.rb
require 'faker'

FactoryGirl.define do
  factory :comment do
    user
    expense
    comment { Faker::Lorem.word }
  end
  factory :invalid_comment, parent: :comment do 
    expense nil
  end
end