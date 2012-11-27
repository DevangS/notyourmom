# spec/controllers/expenses_controller_spec.rb
require 'spec_helper'

describe ExpensesController do

  	before (:each) do
    	@user = Factory.create(:user)
    	sign_in @user
  	end

	describe "GET #index" do
	  it "gets all of the expenses in the current household"
	  
	  it "renders the :index view if there is an logged in user" do
	    get 'index'
    	response.should be_success
	  end

	  it "does not renders the :index view if there isn't an logged in user" do
	  	sign_out user
	    get 'index'
    	response.should_not be_success
	  end
	end
end