# spec/controllers/households_controller_spec.rb
require 'spec_helper'

describe HouseholdsController do

	describe "GET #index" do
	  it "renders the :index view if there is an logged in user" do
	  	user = FactoryGirl.create(:user)
        sign_in user
	    get 'index'
    	response.should be_success
    	sign_out user
	  end

	  it "does not renders the :index view if there isn't an logged in user" do
	    get 'index'
    	response.should_not be_success
	  end
	end
end