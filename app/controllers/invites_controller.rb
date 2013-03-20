class InvitesController < ApplicationController
  
  
  def create
    @invite=Invite.new :email => params[:email]
    @invite.user=current_user
    @invite.save 
    
    Invite.mail_invite(@invite.email, current_user)
    
    redirect_to new_pair_path 
  end
  
  
end
