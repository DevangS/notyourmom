# spec/controllers/users_controller_spec.rb
require 'spec_helper'

describe UsersController do

	before (:each) do
  		@household = FactoryGirl.create(:household)
    	@user = FactoryGirl.create(:user, :household => @household)
    	sign_in @user
  	end

	describe "GET #index" do
	  
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
		it "shows the requested user" do
			user = FactoryGirl.create(:user, :household => @household)
			get :show, id: user
			assigns(:user).should eq(user)
		end

		it "renders the :show view" do
			user = FactoryGirl.create(:user, :household => @household)
			get :show, id: user
			response.should be_success
		end
	end
 
	describe "GET #new" do
		it "assigns a new User to @user"
    	it "renders the :new template"
	end

	describe "POST #create" do
		context "with valid attributes" do
	     	it "saves the new user in the database" do
			    expect{
			    	post :create, user: FactoryGirl.attributes_for(:user)
			     }.to change(User,:count).by(1)
			end
		      
	    end
	    
	    context "with invalid attributes" do
	     	it "does not save the new user in the database" do
			    expect{
			    	post :create, user: FactoryGirl.attributes_for(:invalid_user)
			    }.to_not change(User,:count)
			end
	      	it "re-renders the :new template"  do
		      	post :create, user: FactoryGirl.attributes_for(:invalid_user)
		      	response.should render_template :new
		    end
	    end
	end

	describe "GET #edit" do
	  it "renders the :edit view if there is an logged in user" do
		user = FactoryGirl.create(:user, :household => @household)
		get :edit, id: user
    	response.should be_success
	  end

	  it "does not renders the :edit view if there isn't an logged in user" do
		user = FactoryGirl.create(:user, :household => @household)
		sign_out @user
		get :edit, id: user
    	response.should_not be_success
	  end
	end

	describe "POST #create"

	describe "PUT #update"

	describe "DELETE #destroy" do
		before :each do
		    @testUser = FactoryGirl.create(:user, :household => @household)
		end

		it "deletes the user" do		
		    expect{
		    	delete :destroy, id: @testUser     
		    }.to change(User,:count).by(-1)
	  	end
    
		it "redirects to users#index" do
			delete :destroy, id: @testUser
		    response.should redirect_to users_url
		end
	end
end