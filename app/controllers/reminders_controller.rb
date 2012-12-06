require 'date'
class RemindersController < ApplicationController
  before_filter :authenticate_user!

  # GET /reminders
  # GET /reminders.json
  def index
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
  end

  # GET /reminders/new
  # GET /reminders/new.json
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.json
  def create
    #params[:reminder][:date] = DateTime.parse(params[:reminder][:date])
    @reminder = Reminder.new(params[:reminder])
    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.json
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    item = @reminder.expense.item
    @reminder.destroy
    flash[:notice] = 'Reminder for the expense ' + item + ' has been removed.'
    redirect_to :back 
  end

  def send_now
    @expense = Expense.find(params[:id])
    @expense.send_reminders()
    flash[@expense.id] = 'Reminder emails were successfully sent for the expense ' + @expense.item + '.'
    redirect_to :back
  end

  def send_later 
    render :text => params.to_yaml
    # Do an update
    #if not params[:reminder][:id].blank?
    #  @reminder = Reminder.find(params[:reminder][:id])
    #  expense_id = @reminder.expense_id
    #  params[:reminder].delete(:id)
    #  if @reminder.update_attributes(params[:reminder])
    #    flash[expense_id] = {:notice => 'A reminder was ' +
    #      'successfully replaced.'}
    #  else
    #    flash[expense_id] = {:error => 'Failed to replace this ' +
    #      'reminder.'}
    #  end
    ## Create a new reminder
    #else
    #  params[:reminder].delete(:id)
    #  @reminder = Reminder.new(params[:reminder])
    #  expense_id = @reminder.expense_id
    #  if @reminder.save
    #    flash[expense_id] = {:notice => 'Successfully created a new reminder.'}
    #  else
    #    flash[expense_id] = {:error => 'Failed to create a new reminder.'}
    #  end
    #end
    #redirect_to :back
  end

  def delete_button
    expense = Expense.find(params[:id])
    item = expense.item
    expense.reminder.destroy
    flash[expense.id] = {:notice => 'Reminder has been removed.'}
    redirect_to :back 
  end
end
