# spec/controllers/comments_controller_spec.rb
require 'spec_helper'

describe CommentsController do

	before (:each) do
  		@household = FactoryGirl.create(:household)
    	@user = FactoryGirl.create(:user, :household => @household)
    	sign_in @user
  	end

	describe "GET #index"

	describe "GET #show"
 
	describe "GET #new"

	describe "POST #create" do
		context "with valid attributes" do
	      	it "saves the new comment in the database" do
			    expect{
			    	post :create, comment: FactoryGirl.attributes_for(:comment)
			     }.to change(Comment,:count).by(1)
			end
		      
	    end
	    
	    context "with invalid attributes" do
	      it "does not save the new comment in the database" do
			    expect{
			    	post :create, comment: FactoryGirl.attributes_for(:invalid_comment)
			     }.to_not change(Comment,:count)
			end
	    end
	end

	describe "GET #edit"

	describe "POST #create"

	describe "PUT #update"

	describe "DELETE #destroy" do
		before :each do
		    @comment = FactoryGirl.create(:comment)
		end

		it "deletes the comment" do		
		    expect{
		    	delete :destroy, id: @comment    
		    }.to change(Comment,:count).by(-1)
	  	end
	end
end