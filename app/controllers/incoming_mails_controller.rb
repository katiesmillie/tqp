class IncomingMailsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
   def create

      @subject=params[:headers][:Subject]    
      @round=Round.where(:id => @subject[/\d+/]).first
      @question=@round.question
      
      @answer=Answer.new :round_id => @round.id, :question_id => @question.id
      @answer.body=params[:reply_plain]
      
      @answer.user=User.where(:email => params[:envelope][:from]).first
      
      @user=@answer.user
      @pair=@user.pair
    
      if @answer.save 
        User.mail_answer(@user, @round)
        render :text => 'Answer saved', :status => 200
      else
        render :text => 'Answer not saved', :status => 400
      end
     
    end
end
