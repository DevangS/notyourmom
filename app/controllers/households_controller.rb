
class HouseholdsController < ApplicationController
  before_filter :authenticate_user!

  # GET /households
  # GET /households.json
  def index
    @households = Household.where(:id => current_user.household_id)
    @members = User.where("household_id = ? AND id <> ?",current_user.household_id,current_user.id)

    members = User.where('id != ? AND household_id = ?', current_user.id, current_user.household_id)
    @consolidated_debts = members.map{|member| {:member => member, :value => current_user.consolidated_debt_with(member)}}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @households }
      format.json { render json: @members }
    end
  end


  # GET /households/1
  # GET /households/1.json
  def show
    @household = Household.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @household }
    end
  end

  # GET /households/new
  # GET /households/new.json
  def new
    @household = Household.new
    @household.head = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @household }
    end
  end

  # GET /households/1/edit
  def edit
    @household = Household.find(params[:id])
    #TODO: verify user is head of household before letting edit household
  end

  # POST /households
  # POST /households.json
  def create
    @household = Household.new(params[:household])
    #set head of household to be the creator of the household
    @household.head = current_user

    respond_to do |format|
      if @household.save
        #insecure way of making current user join household but devise doesn't let me have nice thigns
        current_user.join_household(@household).save(:validate => false)
        format.html { redirect_to @household, notice: 'Household was successfully created.' }
        format.json { render json: @household, status: :created, location: @household }
      else
        format.html { render action: "new" }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /households/1
  # PUT /households/1.json
  def update
    @household = Household.find(params[:id])

    respond_to do |format|
      #verify selected head of household is actually member of that household
      if @household.members.include?(User.find(params[:household]['head_id'])) and @household.update_attributes(params[:household])
        format.html { redirect_to @household, notice: 'Household was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.json
  def destroy
    @household = Household.find(params[:id])
    #terrible way of leaving household, but devise doesn't let me have nice things
    @household.members {|member| member.leave_household.save(:validate=>false)}
    Expense.delete_all(:household_id => @household.id)
    @household.destroy

    respond_to do |format|
      format.html { redirect_to households_url }
    # format.json { head :no_content }
      format.json { render json: @household, status: :deleted}
    end
  end

  def leave
    @household = Household.find(params[:id])
    if current_user.is_head_of_house
       @household.members.each { |member|
         if member != current_user
           @household.head = member
           break
         end
       }
       @household.save
    end
    current_user.leave_household.save(:validate=>false)

    respond_to do |format|
      format.html { redirect_to households_url }
      format.json { render json: @household}
    end
  end

  def exile
    @household = Household.find(params[:id])
    @user = User.find(params[:user_id])
    if current_user.is_head_of(@household) and @user.household == @household
      @user.leave_household.save(:validate => false)
    end

    respond_to do |format|
      format.html { redirect_to households_url }
      format.json { render json: @household}
    end
  end

end
