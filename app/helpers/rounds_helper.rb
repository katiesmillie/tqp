module RoundsHelper

  
  def comment_present(round)
    if round.comments.count > 0
      yield
    end
  end
  
  
  def comment_edit(comment)
    if comment.author == current_user
      yield
    end
  end
  
  
  def answer_edit(answer)
    if answer.user == current_user
      yield
    end
  end
         
  

  
end
