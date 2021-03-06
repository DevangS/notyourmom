class InvitationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    invitation = Invitation.new(params[:invitation])
    invitation.sender_id = current_user.id
    invitation.sent_at = Time.now

    if !current_user.household_id.blank?
      hoh = Household.find(current_user.household_id).head_id
    else
      flash[:notice] = "Sorry invitation not sent, you are not the head of household"
      redirect_to households_path
    end
    validateEmail = Invitation.where("recipient_email = ?", invitation.recipient_email)
    existingUser = User.where("email = ?", invitation.recipient_email)

    if !validateEmail.blank?
      flash[:notice] = "Sorry invitation already sent to #{invitation.recipient_email}." 
      redirect_to households_path
    elsif !existingUser.blank?
      flash[:notice] = "Sorry user already registered."
      redirect_to households_path
    else
      if invitation.save   
        if user_signed_in?  
          invitation_url = "http://notyourmom.heroku.com #{invitation.token}"         
          # Mailer.invitation(invitation, new_user_registration_url(:token => "/#{invitation.token}")).deliver
          Mailer.invitation(invitation).deliver
          flash[:notice] = "Thank you invitation sent!"
          redirect_to households_path
        else
          flash[:notice] = "Unable to send invitation, please try again"
          redirect_to households_path
        end
      end
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    flash[:notice] = @invitation.recipient_email + " successfully uninvited"
    redirect_to households_path
=begin
    invitation = Invitation.find(params[:invitation_id])
    if(invitation.destroy)
      flash[:notice] = invitation.recipient_email + "successfully uninvited"
      redirect_to households_path
    else
      redirect_to root
    end
=end

  end
end
