
class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.where(:resolved => false, :household_id => current_user.household_id)
    @expenses_done = Expense.where(:resolved => true, :household_id => current_user.household_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
      format.json { render json: @expenses_done }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
    @users = User.where(:household_id => current_user.household_id)

    #need to do it so the debt fields appear for everyone in the household
    #right now it generates one for each member
    split = @users.count

    @expense.reminder = Reminder.new
    @reminder = @expense.reminder
    @reminder.expense = @expense
    @reminder.expense_id = @expense.id

    @users.each do |u|
        d = @expense.debts.build(:expense => @expense, :user => u)
        d.user_id = u.id
        d.expense_id = @expense.id
        d.percentage_owed = 100.0  / split
    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
    #@expense.user = current_user
    #should probably be done in new (need session)
   

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])

    debts = Debt.where(:expense_id => @expense.id)
    debts.each do |d|
      d.destroy
    end

    #TODO destory tags
    #TODO destory comments

    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end

  def search
    @expenses = []
    @tag = Tag.find_by_name( params[:search])
    if ( !@tag.nil? )
       @expenses = Expense.where(:household_id => current_user.household_id).tagged_with(@tag.name)
    end


    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
end