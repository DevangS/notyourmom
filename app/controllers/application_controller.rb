class ApplicationController < ActionController::Base
  protect_from_forgery

    @comments = Comment.all
    @texpenses = Expense.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
      format.json { render json: @texpenses }
    end 

end
