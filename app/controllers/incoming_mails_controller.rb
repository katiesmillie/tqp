class IncomingMailsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
   def create
      # Rails.logger.info params[:headers][:subject]
      # Rails.logger.info params[:envelope][:from]
      # Rails.logger.info params[:plain]
      # Rails.logger.info params[:html]    

      @subject=params[:headers][:Subject]    
      @round=Round.where(:id => @subject[/\d+/]).first
      @question=@round.question
      
      @answer=Answer.new :round_id => @round.id, :question_id => @question.id
      @answer.body=params[:reply_plain]
      
      @answer.user=User.where(:email => params[:envelope][:from]).first
      
      @user=@answer.user
      @pair=@user.pair
      
      #if round belongs to the user pair then save
      
      if @round.pair == @pair && @round.question.answer.nil?
        @answer.save 
        render :text => 'Answer saved', :status => 200
      else
        render :text => 'Answer not saved', :status => 400
      end
     
    
    end

end
