class Mailer < ActionMailer::Base
  default from: "noyomodotcom@gmail.com"

  def invitation(invitation, signup_url)    
    @user = User.find(invitation.sender_id)
    @signup_url = signup_url
    @token = invitation.token
    mail(:to => invitation.recipient_email,
         :subject => "You have been Invited!"
    )
    

    # recipients invitation.recipient_email
    # from       "noyomodotcom@gmail.com"
    # subject    "You have been invited!"
    # body passing variables that are available in the view file
    # body :signup_url => signup_url, @user => User.find(invitation.sen) 


    #recipients   invitation.recipient_email
    #subject  'Invitation to noyomo.com'
    #from     'noyomodotcom@gmail.com'
    #sent_on  Time.now 
    # body    :invitation => invitation, :signup_url => signup_url

    invitation.update_attribute(:sent_at, Time.now)
  end
end