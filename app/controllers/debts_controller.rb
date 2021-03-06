class DebtsController < ApplicationController
  before_filter :authenticate_user!

  # GET /debts
  # GET /debts.json
  def index
    @expenses = Expense.where(:household_id => current_user.household_id, :resolved => false)
    @debts = Debt.where(:user_id => current_user.id, :paid => false)
    @debts_paid = Debt.where(:user_id => current_user.id, :paid => true)

    #get all members of the household excluding current user
    members = User.where('id != ? AND household_id = ?', current_user.id, current_user.household_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @debts }
      format.json { render json: @expenses }
    end
  end

  # GET /debts/consolidate
  # GET /debts/consolidate.json
  def consolidate 

    @debts = Debt.where(:user_id => current_user.id, :paid => false)
    members = User.where('id != ? AND household_id = ?', current_user.id, current_user.household_id)
    @consolidated_debts = members.map{|member| {:member => member, :value => current_user.consolidated_debt_with(member)}}

    respond_to do |format|
      format.html # index.html.erb
    end

  end

  # GET /debts/1
  # GET /debts/1.json
  def show
    #if params[:id].match(/[0-9]+/).nil?
    #  redirect_to :action => consolidate
    #else
      @debt = Debt.find_by_id(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @debt }
      end
    #end
  end

  # GET /debts/new
  # GET /debts/new.json
  def new
    @debt = Debt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @debt }
    end
  end

  # GET /debts/1/edit
  def edit
    @debt = Debt.find(params[:id])
  end

  # POST /debts
  # POST /debts.json
  def create
    @debt = Debt.new(params[:debt])

    respond_to do |format|
      if @debt.save
        format.html { redirect_to @debt, notice: 'Debt was successfully created.' }
        format.json { render json: @debt, status: :created, location: @debt }
      else
        format.html { render action: "new" }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /debts/1
  # PUT /debts/1.json
  def update
    @debt = Debt.find(params[:id])

    respond_to do |format|
      if @debt.update_attributes(params[:debt])
        format.html { redirect_to @debt, notice: 'Debt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt = Debt.find(params[:id])
    @debt.destroy

    respond_to do |format|
      format.html { redirect_to debts_url }
      format.json { head :no_content }
    end
  end

end
