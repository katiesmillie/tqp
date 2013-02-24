class QuestionsController < ApplicationController

#question is created when user selects question for next day, or automatically chosen
  
  def new
    @question1=Question.scoped.sample
    @question2=Question.scoped.sample
    @question3=Question.scoped.sample  
  end
  
  
  def create
    if params[:body].present? #user created a new question
      @question=Question.new :body => params[:body]
      @question.save
    
    else #user selected a exisitng question
      @question=Question.find params[:question_id]
    end

    @pair=current_user.pair
    @last_round=@pair.rounds.last
    
    @round=Round.where(:round_date => 1.day.from_now.midnight).first_or_create(:question_id => @question.id, :pair_id => @pair.id)
      redirect_to round_path(:id => @last_round.id) 
      
    end      

  end
end
