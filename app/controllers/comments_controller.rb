class CommentsController < ApplicationController
  
  def create
    @round=Round.find params[:round_id]
    @comment=Comment.create :body => params[:body],:author_id => current_user.id, :round_id => params[:round_id]
    
    User.mail_comment(current_user, @round, @comment)

    redirect_to round_path(:id => params[:round_id])

  end
  
  def edit
    @comment=Comment.find params[:id]
  end
  
  def update
    @comment=Comment.find params[:id]
    @comment.body = params[:body]
    @comment.save
  
    redirect_to round_path
  end
  
  
end
