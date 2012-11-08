# spec/models/user_spec.rb
require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  #check validation
  it "is invalid without a firstName" do
  	FactoryGirl.build(:user, firstName:nil).should_not be_valid
  end
  it "is invalid without a lastName" do
  	FactoryGirl.build(:user, lastName:nil).should_not be_valid
  end
  it "is invalid without a email" do
  	FactoryGirl.build(:user, email:nil).should_not be_valid
  end
  it "is invalid without a password" do
  	FactoryGirl.build(:user, password:nil).should_not be_valid
  end
  #check methods
  it "prints out full name as a string" do
  	FactoryGirl.build(:user, firstName:"John", lastName:"Doe").full_name.should == "John Doe"
  end
end