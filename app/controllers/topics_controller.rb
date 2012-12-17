class TopicsController < ApplicationController
	def index
		@group = Group.find_by_id(params[:group_id])

		@topics = Topic.where(:group_id => params[:group_id]).paginate(:page => params[:page]).order('created_at DESC')
		
		if current_user
			@gu = GroupUser.find_by_group_id_and_user_id(@group.id, current_user.id)
		end

		@members = @group.members
		
	end


	def new
		@group = Group.find_by_id(params[:group_id])

		if current_user.groups.include? @group
		   @page_title = t(:new_topic)
		else
		   redirect_to  group_topics_path,  :notice  => t(:user_not_belong_to_group)
		end
	end

	def create
		@group = Group.find_by_id(params[:group_id])

		params[:topic][:content] = params[:topic][:content].gsub(/\r\n/,"<br/>")
		@topic = @group.topics.create(params[:topic])
		@topic.ip =  request.ip

		if @topic.save
		  #update_photos(params[:photo_id],@topic)
		  
		  #@topic.user.timeline(@topic)

		  @group.update_attributes({:topic_num  => @group.topic_num + 1})
		  #current_user.update_attributes({:today_topic_num => current_user.today_topic_num + 1})
		  redirect_to topic_path(@topic), :notice  => 'create_topic_success'
		else
		  render  'new'
		end

	end

	def show
		@topic =  Topic.find params[:id]

		@comments = @topic.comments
	end

end
