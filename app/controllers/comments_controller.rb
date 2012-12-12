class CommentsController < ApplicationController
  

  def new
    @comment = Comment.new
  end

  def create

    model_hash = {:topic_id => 'Topic|topic'}

    for key,value in model_hash do
      model_id = eval("params[:#{key}]")
      if model_id
        model_info = value.split('|')
        model_name = model_info.first
        model_instance = Object.const_get(model_name).find(model_id)

        @comment = Comment.create(:content => params[:comment][:content],
                                   :user_id => params[:comment][:user_id],
                                   :commentable => model_instance)

        if @comment.save
          model_instance.update_attributes({:reply_num => model_instance.reply_num + 1})
          eval("@#{model_info.last} = model_instance")

          redirect_to model_instance, notice: 'Comment was successfully created.'
        else
          #create comment error
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
      redirect_to @comment.commentable
    end

  end


end
