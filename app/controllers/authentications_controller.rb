class AuthenticationsController < ActionController::Base
  def index
    @authentications = Authentications.all
  end

  def create
    auth = request.env["omniauth.auth"]
    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
 
    if authentication
      # Authentication found, sign the user in.
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'],
        :uid => omniauth['uid'])
      sign_in_and_redirect(:user, authentication.user)
    else
      # Authentication not found, thus a new user.
      user = User.new
      user.apply_omniauth(auth)

      invite = Invitation.find_by_recipient_email(user.email)
      if invite
        household_id = invite.sender.household.id
        user.household_id = household_id
      end
     
      if user.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        flash[:error] = "Error while creating a user account. Please try again."
        redirect_to root_url
      end
    end
  end
end
