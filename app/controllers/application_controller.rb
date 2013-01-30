class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_user
    redirect_to new_user_session_path unless current_user 
   # unless current_user 
    #  redirect_to new_user_session_path 
    # end
  end
  
end
