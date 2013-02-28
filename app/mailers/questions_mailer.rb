class QuestionsMailer < ActionMailer::Base
  default :from => "admin@thequestionproject.com"
   
  def daily_question(user, question, url)
     @user = user
     @question = question.body
     @url = url
     mail(:to => user.email, :subject => "Your Daily Question")
  end
  
  def pair_answered(user, question, partner, display_answer, url)
    @user = user.first_name
    @question = question.body
    @partner = partner
    @display_answer = display_answer
    @url = url
    mail(:to => partner.email, :subject => "#{@user} answered today's question")
  end

end

