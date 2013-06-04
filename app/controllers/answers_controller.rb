class AnswersController < ApplicationController
  
  before_filter :require_user, :except => :new
  before_filter :require_no_answer, :only => :new
  before_filter :protect_round,  :only => :new
    
  def new
    @question=@round.question
    @user_answers=@question.answers.where(:user_id => current_user.id)
    flash[:mixpanel_record] = "'Question Answered'"

  end
  
  def create
    
    @pair=current_user.pair
    @question=Question.find params[:question_id]
    
    if Round.find params[:round_id]
      @round=Round.find params[:round_id]
    else
      @round=Round.where("round_date = ? AND pair_id = ?", Time.now.midnight, @pair.id).first_or_create(:question_id => @question.id, :pair_id => @pair.id, :round_date => Time.now.midnight)
    end
    
    if @round
      @answer=Answer.new :body => params[:body], :question_id => @question.id, :round_id => @round.id
      @answer.user=current_user
      @answer.save

      User.mail_answer(current_user, @round)
    
    redirect_to round_path(:id => @round.id)
    
    end
    
# removed redirect to new question path for now
    # @future_round=@pair.rounds.where(:round_date => 1.day.from_now.midnight).first
    # if @future_round.nil?
    #   redirect_to new_question_path
    # else
    #   redirect_to round_path(:id => params[:round_id])  
    # end

  end
  
  def index
    @answers=current_user.answers.order "created_at DESC"
    @pair=current_user.pair
  end
  
  def edit
    @answer=Answer.find params[:id]
    @round=@answer.round
    @question=@answer.question
  end
  
  def update
    @round=Round.find params[:round_id]
    @answer=Answer.find params[:id]
    @answer.body = params[:body]
    @answer.save
    redirect_to round_path(:id => @round.id)
  end
  
  protected 
  def require_no_answer
    if current_user.answers.where(:round_id => params[:round_id]).first
      redirect_to round_path(:id => params[:round_id])
    end
  end
  
  def protect_round
    @pair=current_user.pair
    @round=Round.where(:pair_id => @pair.id, :id => params[:round_id]).first
    redirect_to root_path if @round.nil?
   end
   
  
end
  