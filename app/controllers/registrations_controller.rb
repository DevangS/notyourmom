class RegistrationsController < Devise::RegistrationsController
  def new
    token = params[:token] 
    session[:token] = token
    super           
  end

  def create  
    token = session[:token]
    if !token.blank?
      session[:token] = token
    end
    super
  end

  def update
    super
  end
end 