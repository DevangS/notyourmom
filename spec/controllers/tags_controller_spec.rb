# spec/controllers/tags_controller_spec.rb
require 'spec_helper'

describe TagsController do

 	before (:each) do
  		@household = FactoryGirl.create(:household)
    	@user = FactoryGirl.create(:user, :household => @household)
    	sign_in @user
  	end

	describe "GET #index" do
	  it "gets all of the tags in the current household"
	  
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
		before :each do
		    @tag = FactoryGirl.create(:tag)
		end

		it "shows the requested tag" do
			get :show, id: @tag
			assigns(:tag).should eq(@tag)
		end

		it "renders the :show view" do
			get :show, id: @tag
			response.should be_success
		end

		it "shows tagged expenses in the current household" do
			expense = FactoryGirl.create(:expense, :household => @household)
			expense.tag_list = @tag.name
			expense.save
			get :show, id: @tag
			assigns(:expenses).should eq([expense])
		end

		it "does not show tagged expenses not in current household" do
			expense = FactoryGirl.create(:expense)
			expense.tag_list = @tag.name
			get :show, id: @tag
			assigns(:expenses).should_not eq(expense)
		end
	end
 
	describe "GET #new"

	describe "POST #create" do
		context "with valid attributes" do
		    it "saves the new tag in the database" do
			    expect{
			    	post :create, tag: FactoryGirl.attributes_for(:tag)
			     }.to change(Tag,:count).by(1)
			end
	    end

	    context "with invalid attributes" do
		    it "does not save the new tag in the database" do
			    expect{
			    	post :create, tag: FactoryGirl.attributes_for(:invalid_tag)
			     }.to_not change(Tag,:count)
			end
	    end
	end

	describe "GET #edit"

	describe "POST #create"

	describe "PUT #update"

	describe "DELETE #destroy" do
		before :each do
		    @tag = FactoryGirl.create(:tag)
		end

		it "deletes the expense" do		
		    expect{
		    	delete :destroy, id: @tag     
		    }.to change(Tag,:count).by(-1)
	  	end
	end
end