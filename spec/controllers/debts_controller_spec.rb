# spec/controllers/debts_controller_spec.rb
require 'spec_helper'

describe DebtsController do

  	before (:each) do
  		@household = FactoryGirl.create(:household)
    	@user = FactoryGirl.create(:user, :household => @household)
    	sign_in @user
  	end

	describe "GET #index" do
		it "gets all of the outstanding debts of the current user" do
			debts = []
			3.times do 
		  		debts += [FactoryGirl.create(:debt, :user => @user, :paid => false)]
		  	end
		  	get :index
		  	assigns(:debts).should eq(debts)
	 	end

		it "gets all of the paid debts of the current user" do
			debts = []
			3.times do 
		  		debts += [FactoryGirl.create(:debt, :user => @user, :paid => true)]
		  	end
		  	get :index
		  	assigns(:debts_paid).should eq(debts)
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

	describe "GET #show"
 
	describe "GET #new"

	describe "POST #create" do
		context "with valid attributes" do
	      	it "saves the new debt in the database" do
			    expect{
			    	post :create, debt: FactoryGirl.attributes_for(:debt)
			     }.to change(Debt,:count).by(1)
			end
	    end
	    
	    context "with invalid attributes" do
	      	it "does not save the new debt in the database" do
			    expect{
			    	post :create, debt: FactoryGirl.attributes_for(:invalid_debt)
			     }.to_not change(Debt,:count)
			end
	    end
	end

	describe "GET #edit"

	describe "POST #create"

	describe "PUT #update"

	describe "DELETE #destroy" do
		before :each do
		    @debt = FactoryGirl.create(:debt, :user => @user)
		end

		it "deletes the debt" do		
		    expect{
		    	delete :destroy, id: @debt    
		    }.to change(Debt,:count).by(-1)
	  	end
	end
end