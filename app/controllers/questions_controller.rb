class QuestionsController < ApplicationController

  def new
    @user=current_user
    @pair=@user.pair
    @recent_question_ids=Pair.recent_questions(@pair)
    
    @question1=Question.where(["id NOT IN (?)", @recent_question_ids]).sample
    @question2=Question.where(["id NOT IN (?)", @recent_question_ids]).sample
    @question3=Question.where(["id NOT IN (?)", @recent_question_ids]).sample
    
    #want to compare these lists to @recent_question array and elminate any ids that match ids in the array?
    
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
