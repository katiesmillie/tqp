class AnswersController < ApplicationController
  
  before_filter :require_user, :except => :new
  before_filter :require_no_answer, :only => :new
  before_filter :protect_round,  :only => :new
  
  def new
    @question=@round.question
    @user_answers=@question.answers.where(:user_id => current_user.id)
  end
  
  def create
    @round=Round.find params[:round_id]
    @answer=Answer.new :body => params[:body], :question_id => params[:question_id], :round_id => params[:round_id]
    @answer.user = current_user
    @answer.save
    
    User.mail_answer(current_user)
    
    
    if @answer=Answer.where(:round_id => params[:round_id]).count > 1
      redirect_to round_path(:id => params[:round_id])  
    else
      redirect_to new_question_path
    end
    

  end
  
  def index
    @answers=current_user.answers.order "created_at DESC"
    @pair=current_user.pair
  end
  
  def edit
    @answer=Answer.find params[:id]
    @question=@answer.question
  end
  
  def update
    @answer=Answer.find params[:id]
    @answer.body = params[:body]
    @answer.save
    redirect_to answers_path
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
  