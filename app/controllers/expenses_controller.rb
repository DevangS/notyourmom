
class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  # GET /expenses
  # GET /expenses.json
  def index
    time = Time.new
    @the_date = time.year.to_s + '-' +time.month.to_s + "-" + time.day.to_s
    @expenses = Expense.where(:resolved => false, :household_id => current_user.household_id)
    @expenses_done = Expense.where(:resolved => true, :household_id => current_user.household_id)
    @expenses.each do |e|
      if not e.reminder
        e.build_reminder
      end
    end


    if !params[:filter].nil?
      case params[:filter]
      when "7"
        @date = Date.today - 7
      when "30"
        @date = Date.today.at_beginning_of_month
      when "180"
        @date = Date.today.at_beginning_of_month << 6
      when "365"
        @date = Date.today.at_beginning_of_month << 12
      end

      if !@date.nil?
        @expenses = @expenses.where('created_at >= ?', @date)
        @expenses_done = @expenses_done.where('created_at >= ?', @date)
      end
    end

    
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
    @debts = @expense.debts
    @reminder = @expense.reminder
    @comments = @expense.comments
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
      format.json { render json: @debts }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
    @users = User.where("household_id = ?", current_user.household_id)

    #get total number of users in the house hold 
    @split = (100.0 / (@users.count)).round(2)

    @expense.build_reminder
      #@date = params[:month] ? Date.parse(params[:month]) : Date.today

    #remove current user from debt building
    @users = @users.where("id != ?", current_user.id)
    @users.each do |u|
        d = @expense.debts.build(:expense => @expense, :user => u)
        d.user_id = u.id
        d.expense_id = @expense.id
        d.percentage_owed = @split
        d.paid = false
    end

    @payer_split = (100.0 - (@split*@users.count)).round(2) ;

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @editpage = true;
    sum = Debt.where(:expense_id => params[:id]).sum(:percentage_owed)
    @expense = Expense.find(params[:id])
    @split = ((100-sum) * @expense.price) /100
    if not @expense.reminder
      @expense.build_reminder
    end
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
    @expense.user = current_user  

    respond_to do |format|
      if @expense.save
        date = params[:expense][:reminder_attributes][:date]
        if not date.blank?
          params[:expense][:reminder_attributes][:date] = Date.parse(date).to_s
          params[:expense][:reminder_attributes][:expense_id] = @expense.id.to_s
          @expense.reminder = Reminder.new(params[:expense][:reminder_attributes])
        end
        
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

    comments = Comment.where(:expense_id => @expense.id)
    comments.each do |c|
      c.destroy
    end

    reminder = Reminder.where(:expense_id => @expense.id)
    reminder.each do |r|
      r.destroy
    end

    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end

  def search
    @keyword = params[:search]
    @expenses = []
    #@tag = Tag.find_by_name(params[:search])
    @tag = Tag.where('LOWER(name) LIKE ?', "%"+params[:search].downcase+"%" )
    if ( !@tag.nil? )
      @tag.each do |t|
        @expenses += Expense.where(:household_id => current_user.household_id).tagged_with(t.name)
      end
    end

    @expenses += Expense.where('LOWER(item) LIKE ? AND household_id = ?', "%"+params[:search].downcase+"%", current_user.household_id)
    @expenses.uniq!

    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
end