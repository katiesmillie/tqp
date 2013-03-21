class InvitesController < ApplicationController
  
  
  def new
    @user=current_user
  end
  
  
  def create
    @invite=Invite.new :email => params[:email], :message => params[:body]
    @invite.user=current_user
    @invite.save 
    
    Invite.mail_invite(current_user, @invite.email, @invite.message)
    
    redirect_to new_pair_path 
  end
  
  
end
