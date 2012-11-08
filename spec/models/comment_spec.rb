# spec/models/comment_spec.rb
require 'spec_helper'

describe Comment do
  it "has a valid factory" do
  	FactoryGirl.create(:comment).should be_valid
  end
end