class RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:token]
    if !@token.blank?
      invitation = Invitation.find_by_token(@token)
      sender_id = invitation.sender_id
      #session[:recipient_email] = invitation.recipient_email
      @household_id = User.find(sender_id).household_id
    end
    super           
  end

  def create
    super
  end

  def update
    super
  end
end