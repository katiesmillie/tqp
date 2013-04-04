class RoundsController < ApplicationController
  
  before_filter :require_user
  before_filter :require_answer, :only => [:show]
  before_filter :require_pair

  
#each round is a question per day for a pair, each round has a page
  def show
    @round=Round.find params[:id]
    @question=@round.question
    @answers=@round.answers
    @comments=@round.comments
    @pair=current_user.pair
    @future_round=@pair.rounds.where(:round_date => 1.day.from_now.midnight.to_date).first
  end
  
  def index
    @pair=current_user.pair
    @rounds=@pair.rounds.recent 
  end

  
  def require_user
    redirect_to welcome_path unless current_user 
  end
  
  def require_pair  
    @pair=current_user.pair
    redirect_to new_pair_path unless @pair
 end
  
  protected 
  def require_answer
    if current_user.answers.where(:round_id => params[:id]).first.nil?
      redirect_to new_answer_path(:round_id => params[:id])
    end
  end
  
  
  
end
