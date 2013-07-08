class RoundsController < ApplicationController
  
  before_filter :require_user
  # before_filter :require_answer, :only => [:show]
  # before_filter :require_pair

#each round is a question per day for a pair, each round has a page
  
  
  def new
      @user=current_user
      @pair=@user.pair
      
      if @pair
        @recent_rounds=Round.where("created_at > ? AND pair_id = ?", 30.days.ago.midnight, @pair.id).all
      else
        @recent_rounds=Round.where("created_at > ? AND user_id = ?", 30.days.ago.midnight, @user.id).all
      end
      

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
    @user=current_user
    
    # @past_day_round=@pair.rounds.where("id < ?", @round.id).first
    #     @next_day_round=@pair.rounds.where(:round_date => @round.round_date+1.day).first
    
    #a better way to do this is probably to find the next round for that pair with an id < @round.id
    # @past_day_round=@pair.rounds.where("id < ?," @round.id).first --> needs to be ordered correctly
    
    if @pair
      @future_round=@pair.rounds.where(:round_date => 1.day.from_now.midnight).first
    else
      @future_round=@user.rounds.where(:round_date => 1.day.from_now.midnight).first
      
    end
    
  end
  

  def index
      @user=current_user
      @pair=@user.pair

      if @pair
        @partner=@pair.partner(@user.id)
      end

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
      # end

      if flash[:new_question_id]
        @question=Question.where(:id => flash[:new_question_id]).first
        if @pair
          @rounds=@pair.rounds.recent
        else        
          @rounds=@user.rounds.recent
        end

      elsif @pair
        @rounds=@pair.rounds.recent
        @find_round=@pair.rounds.where(:round_date => Time.now.midnight).first

        if @find_round
          @my_answer=@find_round.answers.where(:user_id => @user.id).first
          @partner_answer=@find_round.answers.where(:user_id => @partner.id).first
          if @parnter_answer
            @question=@partner_answer.question
          else
        @question=Question.where("author_id IN (?)", [1, @user.id]).sample
          end
        
        else
        @question=Question.where("author_id IN (?)", [1, @user.id]).sample
        end

      
      else
        @rounds=@user.rounds.recent
        @my_round=@user.rounds.where(:round_date => Time.now.midnight).first
        @question=Question.where("author_id IN (?)", [1, @user.id]).sample
      end


    @rounds_by_month = Round.order("round_date DESC").group_by { |r| "#{r.round_date.month}/#{r.round_date.year}"}


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
