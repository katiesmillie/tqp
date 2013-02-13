class RoundsController < ApplicationController
  before_filter :require_answer, :only => [:show]
  
#each round is a question per day for a pair, each round has a page
  def show
    @round=Round.find params[:id]
    @question=@round.question
    @answers=@round.answers
  end
  
  protected 
  def require_answer
    if current_user.answers.where(:round_id => params[:id]).first.nil?
      redirect_to new_answer_path(:round_id => params[:id])
    end
  end
  
end
