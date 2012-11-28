class HomeController < ApplicationController
  def index 
    
    # For every expense in household that is NOT RESOLVED
	#expenses = Expense.join(:debts).where("household_id = 1 AND resolved = FALSE")
	if user_signed_in?	
		
		@head_id = Household.select("head_id").where("id = ?", current_user.household_id)
		@house = User.where("household_id = ?", current_user.household_id)
		@expenses = Expense.where("household_id = ? AND resolved = FALSE",current_user.household_id)
		@debts = Debt.where(:user_id => current_user.id, :paid => false)
		@users = User.all

    @house_member = User.where(:household_id => current_user.household_id).where(['users.id <> ?', current_user.household.head_id])
    #@house_head = User.find(:id => current_user.household.head_id)
    @house_head = current_user.household.head

	    respond_to do |format|
	    	format.html # index.html.erb
	    	if current_user.household_id != nil
	      		format.json { render json: @house }
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



  #end
  #@debts.each do |debt|
  #  debt.expense = @expenses.find{ |expense| expense.id==debt.expense_id}
  #  debt.owner = debt.expense.user_id
  #  debt.share = debt.percentage_owed * debt.expense.price / 100
  #end



  def get_expense
    @debt = Debt.find(params[:id])
    @expense = Expense.where(:id => debt.expense_id)
  end

end
