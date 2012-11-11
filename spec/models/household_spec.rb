# spec/models/household_spec.rb
require 'spec_helper'

describe Household do
  it "has a valid factory" do
  	FactoryGirl.create(:household).should be_valid
  end
  #check validations 
  it "is invalid without a name" do
  	FactoryGirl.build(:household, name:nil).should_not be_valid
  end
end