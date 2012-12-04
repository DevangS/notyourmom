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
 
	describe "GET #new" do
		it "assigns a new Expense to @expense" 
    	it "renders the :new template"
	end

	describe "POST #create" do
		context "with valid attributes" do
		    it "saves the new expense in the database" do
			    expect{
			    	e = FactoryGirl.build(:expense)
			    	post :create, expense: e.attributes
			     }.to change(Expense,:count).by(1)
			end
		      
		    it "redirects to the show expense page"  do
		      	e = FactoryGirl.build(:expense)
			    post :create, expense: e.attributes
		      	response.should redirect_to Expense.last
		    end
	    end
	    
	    context "with invalid attributes" do
	      	it "does not save the new expense in the database" do
			    expect{
			    	e = FactoryGirl.build(:invalid_expense)
			    	post :create, expense: e.attributes
			     }.to_not change(Expense,:count)
			end
	      	it "re-renders the :new template"do
		      	post :create, expense: FactoryGirl.attributes_for(:invalid_expense)
		      	response.should render_template :new
		    end
	    end
	end

	describe "GET #edit" do
	  it "renders the :edit view if there is an logged in user" do
	    expense = FactoryGirl.create(:expense, :user => @user, :household => @household)
		get :edit, id: expense
    	response.should be_success
	  end

	  it "does not renders the :edit view if there isn't an logged in user" do
	    expense = FactoryGirl.create(:expense, :user => @user, :household => @household)
	    sign_out @user
		get :edit, id: expense
    	response.should_not be_success
	  end
	end
	
	describe "PUT #update"

	describe "DELETE #destroy" do
		before :each do
		    @expense = FactoryGirl.create(:expense, :user => @user, :household => @household)
		end


		it "deletes the expense" do		
		    expect{
		    	delete :destroy, id: @expense      
		    }.to change(Expense,:count).by(-1)
	  	end
    
		it "redirects to expenses#index" do
			delete :destroy, id: @expense
		    response.should redirect_to expenses_url
		end

		it "deletes any debts associated with the expense" do
			debt = FactoryGirl.create(:debt, :expense => @expense)
			expect{
		    	delete :destroy, id: @expense      
		    }.to change(Debt,:count).by(-1)
		end

		it "deletes any comments associated with the expense" do
			comment = FactoryGirl.create(:comment, :expense => @expense)
			expect{
		    	delete :destroy, id: @expense      
		    }.to change(Comment,:count).by(-1)
		end

		it "deletes the reminder associated with the expense" do
			reminder = FactoryGirl.create(:reminder, :expense => @expense)
			expect{
		    	delete :destroy, id: @expense      
		    }.to change(Reminder,:count).by(-1)
		end
	end

	describe "POST #search"
end