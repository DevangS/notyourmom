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
end