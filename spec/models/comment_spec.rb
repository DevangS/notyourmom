# spec/models/comment_spec.rb
require 'spec_helper'

describe Comment do
  it "has a valid factory" do
  	FactoryGirl.create(:comment).should be_valid
  end
  #check validations
  it "is invalid wihout an expense" do
  	FactoryGirl.build(:comment, expense:nil).should_not be_valid
  end
  it "is invalid wihout an user" do
  	FactoryGirl.build(:comment, user:nil).should_not be_valid
  end
  it "is invalid wihout a (text) comment" do
  	FactoryGirl.build(:comment, comment:nil).should_not be_valid
  end
end