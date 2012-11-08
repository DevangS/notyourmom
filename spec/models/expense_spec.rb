# spec/models/contact.rb
require 'spec_helper'

describe Expense do
  it "has a valid factory" do
  	FactoryGirl.create(:expense).should be_valid
  end
  it "is invalid without a user" do
  	FactoryGirl.build(:expense, user: nil).should_not be_valid
  end
  it "is invalid without a price" do
  	FactoryGirl.build(:expense, price:nil).should_not be_valid
  end
  it "is invalid without a item" do
  	FactoryGirl.build(:expense, item:nil).should_not be_valid
  end
end