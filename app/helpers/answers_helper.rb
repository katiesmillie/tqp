module AnswersHelper
  
  def pair_status(round)
    @partner_name = round.pair.partner(current_user.id).first_name
    
      if round.answers.count < 1
        "#{@partner_name.capitalize} has not answered"
       else
         "Submit your reponse to see #{@partner_name}'s answer"
      end
    
  end
    
          
end
