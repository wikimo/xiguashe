class Cpanel::CommentsController < Cpanel::ApplicationController
  
  def index
    @comments = Comment.order_desc_by_created_at(params[:page], Comment.per_page)
  end
  
  def destroy

    @comment = Comment.find(params[:id])

    @comment.destroy

    redirect_to cpanel_comments_path, :notice => t(:delete_success)
  end
end
