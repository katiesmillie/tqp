class AuthenticationsController < ApplicationController
  
  def index
    @authentication = current_user.authentication if current_user
  end
  
  def create
      data = request.env["omniauth.auth"]
      email = data[:info][:email]     
      user = User.find_by_email(email)
      if user.blank?
        user=User.new
        user.email = email
        user.first_name = data[:info][:name]
        user.image = data[:info][:image]
        password_length = 8
        password = Devise.friendly_token.first(password_length)
        user.password = password
        sign_in(user)
      else
        sign_in(user)
      end
      
      redirect_to new_path
      
  end
  
end
