class TopicsController < ApplicationController

#before_filter :logined?, :except => [:index, :show]

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


	def new
		@group = Group.find_by_id(params[:group_id])

	end

	def create
		@group = Group.find_by_id(params[:group_id])

		params[:topic][:content] = params[:topic][:content].gsub(/\r\n/,"<br/>")
		@topic = @group.topics.create(params[:topic])
		@topic.ip = request.ip

		if @topic.save

			@group.update_attributes({:topic_num => @group.topic_num + 1})
			redirect_to topic_path(@topic), :notice => 'create_topic_success'
		else
			render 'new'
	end

end

	def show
		@topic = Topic.find params[:id]

		@topic.update_attributes({:hit_num => @topic.hit_num + 1})
		@comments = @topic.comments

		@group = @topic.group
	end

end