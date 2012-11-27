# spec/controllers/expenses_controller_spec.rb
require 'spec_helper'

describe ExpensesController do

  	before (:each) do
  		@household = FactoryGirl.create(:household)
    	@user = FactoryGirl.create(:user, :household => @household)
    	sign_in @user
  	end

	describe "GET #index" do
	  it "gets all of the unresolved expenses in the current household" do
	  	expense = FactoryGirl.create(:expense, :household => @household)
	  	get :index
	  	assigns(:expenses).should eq([expense])
	  end

	  it "gets all of the resolved expenses in the current household" do
	  	expense = FactoryGirl.create(:expense, :household => @household, :resolved => true)
	  	get :index
	  	assigns(:expenses_done).should eq([expense])
	  end
	  
	  it "renders the :index view if there is an logged in user" do
	    get :index
    	response.should be_success
	  end

	  it "does not renders the :index view if there isn't an logged in user" do
	  	sign_out @user
	    get :index
    	response.should_not be_success
	  end
	end

	describe "GET #show" do
		it "shows the requested expense" do
			expense = FactoryGirl.create(:expense, :user => @user, :household => @household)
			get :show, id: expense
			assigns(:expense).should eq(expense)
		end

		it "renders the :show view" do
			expense = FactoryGirl.create(:expense, :user => @user, :household => @household)
			get :show, id: expense
			response.should be_success
		end
	end
end