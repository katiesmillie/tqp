class IncomingMailsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
   def create
      # Rails.logger.info params[:headers][:subject]
      # Rails.logger.info params[:envelope][:from]
      # Rails.logger.info params[:plain]
      # Rails.logger.info params[:html]    

      @subject=params[:headers][:Subject]    
      @round=Round.where(:id => @subject[/\d+/])
      @question=Question.where(:round_id => @round.id)

      @answer=Answer.new :round_id => @round_id, :question_id => @question.id
      
      if params[:plain].nil?
        @answer.body=params[:html]
      else
        @answer.body=params[:plain]
      end
      
      @answer.user=User.where(:email => params[:envelope][:from]).first
      
      @user=@answer.user
      @pair=@user.pair
      
      #if round belongs to the user pair then save
      
      if @round.pair == @pair && @round.question.answer.nil?
        @answer.save 
      else
        # return some error email or just do nothing
      end
     
      # if params[:envelope][:from] != 'expected_user@example.com'
      #        render :text => 'success', :status => 200
      #      else
      #        render :text => 'Unknown user', :status => 404 # 404 would reject the mail
      #      end
    
    end

end
