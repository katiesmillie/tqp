class NotificationsMailer < ActionMailer::Base
   default :from => "hello@thequestionproject.com"

    def pair_answered(user, question, partner, display_answer, url)
      @user = user.first_name
      @question = question.body
      @partner = partner
      @display_answer = display_answer
      @url = url
      mail(:to => partner.email, :subject => "#{@user} answered a question")
    end

    def pair_commented(user, comment, question, partner, url)
      @user = user.first_name
      @comment=comment.body
      @question = question.body
      @partner = partner
      @url = url
      mail(:to => partner.email, :subject => "#{@user} left a comment")
    end

  
end