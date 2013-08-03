class Cpanel::CommentsController < Cpanel::ApplicationController
  
  def index
    @comments = Comment.find(:all, :order => "created_at desc")
  end
  
  def destroy
    
  end
end
