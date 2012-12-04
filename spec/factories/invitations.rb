# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :invitation do
    sender_id 1
    recipient_email { Faker::Internet.email }
    token "MyString"
    sent_at "2012-11-23 21:03:16"
  end
end
