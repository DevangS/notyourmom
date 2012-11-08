# spec/models/tag_spec.rb
require 'spec_helper'

describe Tag do
  it "has a valid factory" do
  	FactoryGirl.create(:tag).should be_valid
  end
end