class QuestionsMailer < ActionMailer::Base
  default :from => "hello@thequestionproject.com",
          :reply_to => "answer@thequestionproject.com"
          :bcc => "katiesmillie@gmail.com"
          
     
  def daily_question(user, round, question, url)
     @question=question.body
     @round=round
     @url=url
     @user=user.first_name
     mail(:to => user.email, :subject => "Your Daily Question (#{round.id})") 
  
  end
  
  
  def daily_email(user, round, rounds, question, partner, answers, comments, url, last_month, last_week)
      @user=user
      @round=round
      @rounds=rounds
      @question=question.body
      @partner=partner.first_name
      @answers=answers
      @comments=comments
      @url=url
      @last_month=last_month
      @last_week=last_week
      mail(:to => user.email, :subject => "Your Daily Email (#{round.id})") 
   end
  

end

