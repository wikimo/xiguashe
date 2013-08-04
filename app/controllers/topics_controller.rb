class TopicsController < ApplicationController

    before_filter :logined?, :except => [:index, :show, :discovery]

	def index
		@group = Group.find_by_id(params[:group_id])

		@topics = Topic.where(:group_id => params[:group_id]).paginate(:page => params[:page]).order('created_at DESC')

		if current_user
			@gu = GroupUser.find_by_group_id_and_user_id(@group.id, current_user.id)

		end

		@members = @group.members

		@creater = @group.creater

		@managers = @group.managers
	
	end


	def discovery
		@topics = Topic.discovery(params[:page], Topic.per_page)
	end


	def new
		@group = Group.find_by_id(params[:group_id])

	end

	def create
		@group = Group.find_by_id(params[:group_id])

		params[:topic][:content] = params[:topic][:content].gsub(/\r\n/,"<br/>")
		@topic = @group.topics.create(params[:topic])
		@topic.ip = request.ip

		if @topic.save
			update_photos(params[:photo_id],@topic)
			
			@group.update_attributes({:topic_num => @group.topic_num + 1})
			redirect_to topic_path(@topic), :notice => 'create_topic_success'
		else
			render 'new'
		end

	end

	def edit

		@topic = Topic.find(params[:id])

		@group = @topic.group
	end

	def update
		@topic = Topic.find(params[:id])
		params[:topic][:title] = params[:topic][:title].gsub(/\r\n/, "<br/>")
		params[:topic][:content] = params[:topic][:content].gsub(/\r\n/,"<br/>")

		if @topic.update_attributes(params[:topic])
			update_photos(params[:photo_id],@topic)
			redirect_to @topic, :notice => t(:update_success)
		else
			#error
		end
	end

	def show
		@topic = Topic.find params[:id]

		@topic.update_attributes({:hit_num => @topic.hit_num + 1})
		@comments = @topic.comments.order_desc_by_created_at(params[:page], Comment.per_page)

		@group = @topic.group
		
		@user = @topic.user
		
		@user_topics = @user.topics.order_by_created_at.limit(5)
	end

	private 
	    def update_photos (photo_id,topic)
	      photo_id  && photo_id.each do |id|
	        Photo.find(id).update_attributes!(:photoable  => topic)      
	      end  
	    end
end