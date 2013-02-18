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
      # @question.author = current_user
      @question.save
    
    else #user selected a exisitng question
      @question=Question.find params[:question_id]
    end

    @pair=Pair.where("user1_id = ? OR user2_id = ?", current_user.id, current_user.id).first
    @last_round=@pair.rounds.last
    @round=Round.create :question_id => @question.id, :pair_id => @pair.id, :round_date => 1.day.from_now
  
    redirect_to round_path(:id => @last_round.id)
     
  end

end
