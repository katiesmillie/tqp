class NotificationsMailer < ActionMailer::Base
   default :from => "hello@thequestionproject.com"
    layout "mailer"
     
    def pair_answered(user, question, partner, answer, url)
      @user = user.first_name
      @question = question.body
      @partner = partner
      @answer = answer.body
      @url = url
      mail(:to => partner.email, :subject => "#{@user} answered a question") 
    end
    
    
    def pair_answered_hidden(user, question, partner, url)
      # @intro=YAML.load_file("config/emails.yml").sample
      @user = user.first_name
      @question = question.body
      @partner = partner
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
