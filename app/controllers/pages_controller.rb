class PagesController < ApplicationController
  
  def about
  end
  
  def signed_out
  end
  
  def new_user
    @user=current_user
    @pair=@user.pair
    @partner=@pair.partner(@user.id)
    @round=Round.where(:pair_id => @pair.id).first
    @question=@round.question
  end
  
  
end
