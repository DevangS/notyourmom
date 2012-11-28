class Mailer < ActionMailer::Base
  default from: "noyomodotcom@gmail.com"

  def invitation(invitation, signup_url)    
    @user = User.find(invitation.sender_id)
    @signup_url = signup_url
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

  def reminder(debtor, debt, expense)
    @debtor = debtor
    @debt = debt
    @expense = expense
    mail(:to => "cgtheresa@gmail.com",
    :from => "debt-reminder@notyourmom.com",
    :subject => "You have an upcoming debt to pay!")
  end
end