class QuestionsMailer < ActionMailer::Base
  default :from => "hello@thequestionproject.com",
          :reply_to => "answer@thequestionproject.com"
          
          
     
  def daily_question(user, round, question, url)
     @question=question.body
     @round=round
     @url=url
     @user=user.first_name
     mail(:to => user.email, :subject => "Your Question for #{round.round_date.to_date.to_s(:long)} (#{round.id})")
  
  end
  
  
  def daily_email(user, round, rounds, unanswered_rounds, question, partner, answers, comments, url, last_month, last_week)
      @user=user
      @round=round
      @rounds=rounds
      @unanswered_rounds=unanswered_rounds
      @question=question.body
      @partner=partner.first_name
      @answers=answers
      @comments=comments
      @url=url
      @last_month=last_month
      @last_week=last_week
      mail(:to => user.email, :bcc => "katiesmillie@gmail.com", :subject => "Your Question for #{round.round_date.to_date.to_s(:long)} (#{round.id})")
   end
  

end

