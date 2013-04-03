class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => :new_user
  
  def about
  end
  
  def signed_out
  end
  
  def new_user
    @user=current_user
    @pair=@user.pair
    
    @partner=@pair.try(:partner, @user.id)
    return redirect_to new_pair_path unless @partner
    @round=Round.where(:pair_id => @pair.id).first
    @question=@round.question

  end
  
  
end
