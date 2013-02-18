class RoundsController < ApplicationController
  
  before_filter :require_answer, :only => [:show]
  before_filter :require_user
  
#each round is a question per day for a pair, each round has a page
  def show
    @round=Round.find params[:id]
    @question=@round.question
    @answers=@round.answers
  end
  
  def index
    @pair=Pair.where("user1_id = ? OR user2_id = ?", current_user.id, current_user.id)
    @rounds=Round.order "round_date DESC"
      
      @rounds.each do |r|
        if r.answers.count > 0
          @answer_label = "View Round"
        else
          @answer_label = "Answer Question" 
        end
      end
      
  end
  
  def require_user
    redirect_to welcome_path unless current_user 
  end

  protected 
  def require_answer
    if current_user.answers.where(:round_id => params[:id]).first.nil?
      redirect_to new_answer_path(:round_id => params[:id])
    end
  end
  
end
