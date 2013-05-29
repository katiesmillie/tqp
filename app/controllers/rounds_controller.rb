class RoundsController < ApplicationController
  
  before_filter :require_user
  # before_filter :require_answer, :only => [:show]
  before_filter :require_pair

#each round is a question per day for a pair, each round has a page
  
  
  def new
      @user=current_user
      @pair=@user.pair
      @recent_rounds=Round.where("created_at > ? AND pair_id = ?", 30.days.ago.midnight, @pair.id).all

      @recent_question_ids=[]
      @recent_rounds.each do |r|
        @recent_question_ids << r.question.id
      end
    
      if @recent_question_ids
        @question=Question.where(["id NOT IN (?)", @recent_question_ids]).sample
      else
        @question=Question.scoped.sample
      end
        
  end

  
  def show
    @round=Round.find params[:id]
    @question=@round.question
    @answers=@round.answers
    @comments=@round.comments
    @pair=current_user.pair
    
    @past_day_round=@pair.rounds.where("id < ?", @round.id).first
    @next_day_round=@pair.rounds.where(:round_date => @round.round_date+1.day).first
    
    #a better way to do this is probably to find the next round for that pair with an id < @round.id
    # @past_day_round=@pair.rounds.where("id < ?," @round.id).first --> needs to be ordered correctly
    
    
    
    @future_round=@pair.rounds.where(:round_date => 1.day.from_now.midnight).first
  end
  
  def index
      @user=current_user
      @pair=@user.pair
      # @recent_rounds=Round.where("created_at > ? AND pair_id = ?", 30.days.ago.midnight, @pair.id).all
      # 
      #      @recent_question_ids=[]
      #      @recent_rounds.each do |r|
      #        @recent_question_ids << r.question.id
      #      end
      #    
      #      
      #      if @recent_question_ids
      #        @question=Question.where(["id NOT IN (?)", @recent_question_ids]).sample
      #      else
        @question=Question.scoped.sample
      # end
      
      @rounds=@pair.rounds.recent 
      
      @todays_round=@pair.rounds.where(:round_date => Time.now.midnight).first
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
