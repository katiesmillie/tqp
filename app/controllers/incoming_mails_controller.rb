class IncomingMailsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
   def create
      # Rails.logger.info params[:headers][:subject] #why do I need to log all this stuff? do i?
      # Rails.logger.info params[:envelope][:from]
      # Rails.logger.info params[:plain]
      # Rails.logger.info params[:html]    

      @subject=params[:headers][:subject]
      IncomingMails.get_round(@subject)
      
      @question=Question.where (:round_id => @round.id)

      # @answer=Answer.new :round_id => params[:headers][X-Round_Id], :question_id => params[:headers][X-Question-Id]
      @answer=Answer.new :round_id => @round_id, :question_id => @question.id
      
      if params[:plain].nil?
        @answer.body=params[:plain]
      else
        @answer.body=params[:html]
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
