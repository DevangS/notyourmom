# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :user do
    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "12345678"
  end

  factory :invalid_user, parent: :user do
  	firstName nil
  end
end