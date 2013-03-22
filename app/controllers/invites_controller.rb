class InvitesController < ApplicationController
  
  
  def new
    @user=current_user
  end
  
  
  def create
    @invite=Invite.new :email => params[:email], :message => params[:body]
    @invite.user=current_user
    
    
    if params[:kind] == "partner"
      @invite.type="partner"
      @invite.save 
      Invite.mail_invite(current_user, @invite.email, @invite.message)
    elsif params[:kind] == "share"
      @invite.type="share"
      @invite.save 
      Invite.mail_share(current_user, @invite.email, @invite.message)
    end
    

    redirect_to new_pair_path 
  end
  
  
end
