class InvitationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render('create')
  end

  def create
    # Takes :invitation object from view and populates data into new record
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender_id = current_user.id
    @invitation.sent_at = Time.now 
    @hoh = Household.find(current_user.household_id).head_id
    # @validateEmail = Invitation.where("recipient_email = ?", @invitation.recipient_email)

    if @hoh 
      if @invitation.save   
        if user_signed_in?            
          Mailer.invitation(@invitation, new_user_registration_url(:token => "/#{@invitation.token}")).deliver
          flash[:notice] = "Thank you invitation sent!" 
          redirect_to households_path
        else
          flash[:notice] = "Unable to send invitation please try again"
          redirect_to households_path
        end
      end
    else
      flash[:notice] = "Sorry invitation not sent, you are not the head of household"
    end
  end
end
