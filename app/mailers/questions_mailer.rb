class QuestionsMailer < ActionMailer::Base
  default :from => "hello@thequestionproject.com",
          :reply_to => "answer@thequestionproject.com"
     
  def daily_question(user, round, question, url)
     @question=question.body
     @round=round
     @url=url
     @user=user.first_name
     mail(:to => user.email, :subject => "Your Daily Question (#{round.id})")
  end
  

end

