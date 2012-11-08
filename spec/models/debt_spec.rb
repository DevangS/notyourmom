# spec/models/debt_spec.rb
require 'spec_helper'

describe Debt do
  it "has a valid factory" do
  	FactoryGirl.create(:debt).should be_valid
  end
end