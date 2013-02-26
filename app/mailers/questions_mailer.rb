class QuestionsMailer < ActionMailer::Base
  default :from => "admin@thequestionproject.com"
   
  def daily_question(user, question)
     @user = user
     @question = question
     @url = "http://thequestionproject.com"
     mail(:to => user.email, :subject => "Your Daily Question")
  end
  
  def pair_answered (user, pair, round, question, partner, answer)
    @user = user
    @pair = pair
    @round = round
    @question = question
    @partner = partner
    @answer = answer
    mail(:to => user.email, :subject => "#{@parter.first_name} answered today's question")
  end

end

