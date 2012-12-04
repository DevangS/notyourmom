# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reminder do
    expense
    date "2012-11-19 12:04:05"
  end
end
