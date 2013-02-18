class CommentsController < ApplicationController
  
  def create
        @comment=Comment.new :body => params[:body],:author_id => current_user.id, :round_id => params[:round_id]
        @comment.save
        
        redirect_to round_path(:id => params[:round_id])
  end
  
end
