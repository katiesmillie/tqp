class AnswersController < ApplicationController
  
  before_filter :require_user, :except => :new
  
  def new
    @question=Question.scoped.sample
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
  
end
  