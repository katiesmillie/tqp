class AnswersController < ApplicationController
  
  before_filter :require_user, :except => :new
  
  def new
    @question=UserQuestion.scoped.sample
    @user_answers=@question.answers.where(:user_id => current_user.id)
  end
  
  def create
    @answer=Answer.new :body => params[:body], :question_id => params[:question_id]
    @answer.user = current_user
    @answer.save
    redirect_to answers_path
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

  
end
  