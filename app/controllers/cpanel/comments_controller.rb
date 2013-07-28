class Cpanel::CommentsController < ApplicationController
  
  def index
    @comments = Comment.find(:all, :order => "created_at desc")
  end
  
  def destroy
    
  end
end
