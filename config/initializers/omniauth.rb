Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, "107777596051571", "822241b5911fd71a1ee9ab789fe671c3", 
  { :scope => 'email, read_stream, read_friendlists, 
  	friends_likes, friends_status, offline_access' }
 
  # If you want to also configure for additional login services, they would be configured here.
end