class AnswersController < ApplicationController
  
  before_filter :require_user, :except => :new
  before_filter :require_no_answer, :only => :new
  
  def new
    @round=Round.find params[:round_id]
    @question=@round.question
    @user_answers=@question.answers.where(:user_id => current_user.id)
  end
  
  def create
    @answer=Answer.new :body => params[:body], :question_id => params[:question_id], :round_id => params[:round_id]
    @answer.user = current_user
    @answer.save
    
    if @answer=Answer.where (:round_id => params[:round_id]).count > 1
      redirect_to round_path(:id => params[:round_id])
    else
      redirect_to new_question_path
    end
    
  end
  
  def index
    @answers=current_user.answers.order "created_at DESC"
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
  
  def destroy
    @answer=Answer.find params[:id]
    @answer.delete
    redirect_to answers_path
  end
  
  protected 
  def require_no_answer
    if current_user.answers.where(:round_id => params[:round_id]).first
      redirect_to round_path(:id => params[:round_id])
    end
  end

  
end
  