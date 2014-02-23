class CommentsController < ApplicationController
  
  before_filter :logined?
  
  def new
    @comment = Comment.new
  end

  def create

    model_hash = {
                  topic_id: 'Topic|topic',
                  product_id: 'Product|product'
                 }

    for key,value in model_hash do
      model_id = eval("params[:#{key}]")
      if model_id
        model_info = value.split('|')
        model_name = model_info.first
        model_instance = Object.const_get(model_name).find(model_id)
        
        @comment = Comment.create(:content => params[:comment][:content].gsub(/\r\n/,"<br/>"),
                                   :user_id => params[:comment][:user_id],
                                   :commentable => model_instance)

        if @comment.save

          model_instance.update_attributes({:reply_num => model_instance.reply_num + 1})
          
          eval("@#{model_info.last} = model_instance")

          redirect_to  model_instance, :notice => t(:comment_create_success)

        else
          message = ''
          @comment.errors.full_messages.each do |msg|
            message << msg
          end
          flash[:notice] = message
          redirect_to  model_instance
        end

        break

      end 
    end
  end

  def reply_create
    @reply = Comment.create(:content => params[:reply][:content],
                            :user_id => params[:reply][:user_id],
                            :reply_parent_id => params[:id])
    @comment = Comment.find(params[:id])

    if @reply.save
      
    end

  end

end
