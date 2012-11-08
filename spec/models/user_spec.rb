# spec/models/user_spec.rb
require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without a firstName"
  it "is invalid without a lastName"
  it "is invalid without a email"
  it "prints out full name as a string" do
  	FactoryGirl.build(:user, firstName:"John", lastName:"Doe").full_name.should == "John Doe"
  end
end