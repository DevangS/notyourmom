# spec/factories/tags.rb
require 'faker'

FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.word }
  end
  factory :invalid_tag, parent: :tag do
    name nil
  end
end