class HomeController < ApplicationController
  def index 
    
    # For every expense in household that is NOT RESOLVED
	#expenses = Expense.join(:debts).where("household_id = 1 AND resolved = FALSE")
	if user_signed_in?	
		
		@expenses = Expense.joins(:debts).where("household_id = ? AND resolved = FALSE",current_user.household_id)
		@debts = Debt.joins(:expense).where("debts.user_id = ?",current_user.id)
		@users = User.all

	    respond_to do |format|
	    	format.html # index.html.erb
	    	if current_user.household_id != nil
	      		format.json { render json: @expenses }
	      		format.json { render json: @debts }
	      		format.json { render json: @users }
	    		@household_created = TRUE
	    	else
	    		@household_created = FALSE
        		flash[:notice] = "You have not yet created a household. "
    		end
	   	end
	else
       	flash[:notice] = "Please sign in!"
		redirect_to :controller => 'devise/sessions', :action => 'create'
		#render :partial => "devise/sessions/new"
    end
  end

  def banner 

	    respond_to do |format|
	    	format.html 
	   	end
  end

end
