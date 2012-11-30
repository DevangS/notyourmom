require 'spec_helper'

describe Reminder do
  it "has a valid factory" do
  	FactoryGirl.create(:reminder).should be_valid
  end
  #check validations 
  it "is invalid without an expense" do
  	FactoryGirl.build(:reminder, expense:nil).should_not be_valid
  end
    it "is invalid without a date" do
  	FactoryGirl.build(:reminder, date:nil).should_not be_valid
  end
end
