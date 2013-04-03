class InvitesController < ApplicationController
  
  
  def new
    @user=current_user
    @pair=@user.pair
  end
  
  
  def create
    @invite=Invite.new :email => params[:email], :message => params[:body]
    @invite.user=current_user
    
    if params[:kind] == "partner"
      @invite.kind="partner"
      @invite.save 
      Invite.mail_invite(current_user, @invite.email, @invite.message)
      flash[:success]="Your invitation was sent!"
      redirect_to new_pair_path 
    elsif params[:kind] == "share"
      @invite.kind="share"
      @invite.save 
      Invite.mail_share(current_user, @invite.email, @invite.message)
      flash[:success]="Your message was sent!"
      redirect_to new_invite_path 
    end
      
   
  end
  
  
end
