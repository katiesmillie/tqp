class PairsController < ApplicationController

before_filter :authenticate_user!
before_filter :require_no_pair, :only => [:new]

  def new
    @partners=User.where(:email => params[:email])
  end


  def create    
    @partner=User.find params[:partner_id]

    if current_user.pair.nil? && @partner.pair.nil?
      @pair=Pair.create :user1_id => current_user.id, :user2_id => params[:partner_id]
      redirect_to root_path
    else
      flash[:alert_custom]="User already has a partner!"
      redirect_to new_pair_path
    end
    
  end
  
  def show
    @pair=current_user.pair
  end
  
  def destroy
    @pair=current_user.pair
    @pair.delete
    redirect_to pair_path
  end

  def require_no_pair  
     @pair=current_user.pair
     if @pair
       redirect_to root_path
     end
  end


end
