class AnswersController < ApplicationController
  
  def new
    @question=Question.all.sample
  end
  
  def create
    @answer=Answer.create :body => params[:body], :question_id => params[:question_id]
    redirect_to answers_path
    
  end
  
  def index
    @answers=Answer.all
  end
  
end
