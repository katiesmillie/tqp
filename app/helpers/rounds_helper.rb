module RoundsHelper
  
  def answer_label(round)
     if round.answers.count > 0
        "View Round"
      else
        "Answer Question" 
      end
  end
end
