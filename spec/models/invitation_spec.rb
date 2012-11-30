require 'spec_helper'

describe Invitation do
  it "has a valid factory" do
  	FactoryGirl.create(:invitation).should be_valid
  end
  #check validations 
  it "is invalid without a recipient email" do
  	FactoryGirl.build(:invitation, recipient_email:nil).should_not be_valid
  end
end
