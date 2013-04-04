Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  
  #create linked in app
  provider :linked_in, '54lpcvck0g3c', '48fK1J3k9nw6Pp51'
  #development
  provider :facebook, '314070718699030', '9aa5266e67b68242c6324bf96cb3b392' if Rails.env.development?

#create another facebook app for production  
  # provider :facebook, '314070718699030', '9aa5266e67b68242c6324bf96cb3b392' if Rails.env.production?
  
  
end
