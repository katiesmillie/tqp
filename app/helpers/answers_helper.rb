module AnswersHelper
  
  def pair_status(round)
    @partner_name = round.pair.partner(current_user.id).first_name
    
      if round.answers.count < 1
       else
         "Submit your response to see #{@partner_name}'s answer"
      end
    
  end
    
          
end
