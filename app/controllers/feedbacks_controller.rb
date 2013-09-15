class FeedbacksController < ApplicationController
  
  before_filter :logined?, :except => [:index]



  def index

  	@feedbacks = Feedback.order_desc_by_created_at

  end

  def create
  	
  	@feedback = Feedback.create(content: params[:feedback][:content].gsub(/\r\n/,"<br/>"), 
  								user_id: params[:feedback][:user_id])

  	if @feedback.save
  		redirect_to feedbacks_path, notice: t(:create_success)
  	end

  end


end
