Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, "455996127785930", "cc7631300dc0f2d667cd50e83b4f8bd7", 
  { :scope => 'email, read_stream, read_friendlists, 
  	friends_likes, friends_status, offline_access' }
 
  # If you want to also configure for additional login services, they would be configured here.
end