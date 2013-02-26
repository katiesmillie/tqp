class QuestionsMailer < ActionMailer::Base
  default :from => "admin@thequestionproject.com"
   
  def daily_question(user, question)
     @user = user
     @question = question.body
     @url = "http://beta.thequestionproject.com"
     mail(:to => user.email, :subject => "Your Daily Question")
  end
  
  def pair_answered(user, question, partner, display_answer)
    @user = user
    @question = question.body
    @partner = partner.first_name
    @display_answer = display_answer
    mail(:to => user.email, :subject => "#{@partner} answered today's question")
  end

end

