class QuestionsMailer < ActionMailer::Base
  default :from => "admin@thequestionproject.com"
   
  def daily_question(user, question)
     @user = user
     @question = @round.question
     @url = "http://thequestionproject.com"
     mail(:to => user.email, :subject => "Your Daily Question")
    

     
  end
  
    @user = user
    @question = question
    mail(:to => user.email, :subject => "Your Daily Question")
  end
end
