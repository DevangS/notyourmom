class RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:token]
    if !@token.blank?
      invitation = Invitation.find_by_token(@token)
      sender_id = invitation.sender_id
      session[:invitation_id] = invitation.id
      @household_id = User.find(sender_id).household_id
    end
    super           
  end

  def create
    if !session[:invitation_id].blank?
      invitation = Invitation.find(session[:invitation_id])
      invitation.accepted = true
      invitation.save
      session[:invitation_id] = invitation.id
    end
    super
  end

  def update
    super
  end
end