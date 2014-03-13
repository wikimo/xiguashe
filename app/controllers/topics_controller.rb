class TopicsController < ApplicationController

  before_filter :logined?, :except => [:index, :show, :discovery]
  before_filter :find_topic, :only => [:edit,:update,:show, :get_comment_user]

	def index
		@topics = Topic.short.includes(:user).order_by_created_at_desc.paginate(:page => params[:page])
	end


	def new
    @topic = Topic.new
	end

	def create

		@topic = Topic.create(params[:topic])

		@topic.ip = request.ip

		if @topic.save

      update_photo(@topic, params[:photo_id])

			redirect_to topic_path(@topic), :notice => t(:create_success)
		else
			render 'new'
		end


	end

	def edit

	end

	def update
		params[:topic][:content] = content_filter(params[:topic][:content])

		if @topic.update_attributes(params[:topic])
      update_photo(@topic, params[:photo_id])
			redirect_to @topic, :notice => t(:update_success)
		else

		end
	end

	def show
		@topic.update_attributes({:hit_num => @topic.hit_num + 1})
		@comments = @topic.comments.paginate(page:params[:page])
	end

	def get_comment_user
		
		users = []

		@topic.comments.each do |comment|

			users << [comment.user.id, comment.user.nickname] unless comment.user.id == @topic.user.id
		end 

		render json: users.uniq

	end

	private

	    def content_filter(content)
	    	substitute = '\r\n';
	  		content = content.gsub(/^[#{substitute}]+|[#{substitute}]+$/, '').gsub(/\r\n/,"<br/>")
	    end

	    def find_topic
	    	@topic =  Topic.where(:id => params[:id]).first

      		render_404 if @topic.nil?
	    end

end
