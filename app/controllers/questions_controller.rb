class QuestionsController < ApplicationController

  def new
    @question1=Question.scoped.sample
    @question2=Question.scoped.sample
    @question3=Question.scoped.sample  
  end
  
  def create
    if params[:body].present? #user created a new question
      @question=Question.new :body => params[:body]
      @question.save
    
    else #user selects an existing question
      @question=Question.find params[:question_id]
    end

    @pair=current_user.pair
    @round=Round.where("round_date = ? AND pair_id = ?", 1.day.from_now.midnight, @pair.id).first_or_create(:question_id => @question.id, :pair_id => @pair.id, :round_date => 1.day.from_now.midnight)
    
    redirect_to root_path
      
    end      

end
