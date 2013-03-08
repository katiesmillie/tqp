class PairsController < ApplicationController

# connecting two users together as a pair, this happens on registration

  def new
    @partners=User.where :email => params[:email]
  end


  def create    
      @partner=User.find params[:partner_id]

    if current_user.pair.nil? && @partner.pair.nil?
      @pair=Pair.create :user1_id => current_user.id, :user2_id => params[:partner_id]
      @question=Question.scoped.sample
      @round=Round.create :question_id => @question.id, :pair_id => @pair.id, :round_date => Time.now.midnight
      redirect_to root_path
    else
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


end
