# spec/models/debt_spec.rb
require 'spec_helper'

describe Debt do
  it "has a valid factory" do
  	FactoryGirl.create(:debt).should be_valid
  end
  #check validations
  it "is invalid without an expense" do
  	FactoryGirl.build(:debt, expense:nil).should_not be_valid
  end
  it "is invalid without an user" do
  	FactoryGirl.build(:debt, user:nil).should_not be_valid
  end
  it "is invalid if percentage_owed is less than 0" do
    FactoryGirl.build(:debt, percentage_owed:-1).should_not be_valid
  end
  it "is invalid if percentage_owed is equal to 0" do
    FactoryGirl.build(:debt, percentage_owed:0).should_not be_valid
  end
  it "is invalid if percentage_owed is greater than 100" do
    FactoryGirl.build(:debt, percentage_owed:101).should_not be_valid
  end
end