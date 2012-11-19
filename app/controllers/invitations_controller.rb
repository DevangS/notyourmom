class InvitationsController < ApplicationController
	before_filter :authenticate_user!

	def index
		render('create')
	end

	def create
		# Takes :invitation object from view and populates data into new record
		@invitation = Invitation.new(params[:invitation])
		@invitation.sender_id = current_user.id
		@invitation.set_at = Time.now	

		if @invitation.save		
			if user_signed_in?	
				Mailer.invitation(@invitation, new_user_registration_url(@invitation.token))
				flash[:notice] = "Thank you invitation sent!"
				redirect_to invitations_path
			else
				flash[:notice] = "Unable to send invitation please try again"
				redirect_to invitations_path
			end
		end		
	end
end
