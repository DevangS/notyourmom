# spec/controllers/households_controller_spec.rb
require 'spec_helper'

describe HouseholdsController do

	before (:each) do
  		@household = FactoryGirl.create(:household)
    	@user = FactoryGirl.create(:user, :household => @household)
    	sign_in @user
  	end

	describe "GET #index" do

	  it "gets all of users in the current household" do
	  	housemembers = [@user]
	  	3.times do 
	  		housemembers += [FactoryGirl.create(:user, :household => @household)]
	  	end
	  	get :index
	  	assigns(:members).should eq(housemembers)
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
		it "shows the household" do
			get :show, id: @household
			assigns(:household).should eq(@household)
		end

		it "renders the :show view" do
			get :show, id: @household
			response.should be_success
		end
	end
 
	describe "GET #new" do
		it "assigns a new household to @household"
    	it "renders the :new template"
	end

	describe "POST #create" do
		context "with valid attributes" do
	      	it "saves the new household in the database" do
			    expect{
			    	post :create, household: FactoryGirl.attributes_for(:household)
			    }.to change(Household,:count).by(1)
			end
	      it "sets the creator of the household as the head of house"
	    end
	    
	    context "with invalid attributes" do
	     	it "does not save the new household in the database" do
			    expect{
			    	post :create, household: FactoryGirl.attributes_for(:invalid_household)
			    }.to_not change(Household,:count)
		  	end
	      	it "re-renders the :new template" do
		      	post :create, household: FactoryGirl.attributes_for(:invalid_household)
		      	response.should render_template :new
		    end
	    end
	end

	describe "GET #edit" do
	  it "renders the :edit view if there is an logged in user" do
		get :edit, id: @household
    	response.should be_success
	  end
	end

	describe "POST #create"

	describe "PUT #update"

	describe "DELETE #destroy" do
		before :each do
		    @testHousehold = FactoryGirl.create(:household)
		end

		it "deletes the household" do		
		    expect{
		    	delete :destroy, id: @testHousehold     
		    }.to change(Household,:count).by(-1)
	  	end
    
	end
end