class Cpanel::TopicsController < Cpanel::ApplicationController


	def index
		@topics = Topic.search_in_cpanel(params[:search],params[:page], Topic.per_page)
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		redirect_to cpanel_topics_path
	end


	def change_edit
		@topic = Topic.find(params[:id])
		
		@groups = Group.useing_groups_except_joined(@topic.group.id, params[:page], Topic.per_page)
	end


	def change_update

		@topic = Topic.find params[:id]
		@group = Group.find(params[:group])

		@gu = GroupUser.find_by_group_id_and_user_id(@group.id, @topic.user.id)

		if @gu.nil?
			GroupUser.create(group_id: @goup.id, user_id: @topic.user.id)
		end

		@topic = Topic.find params[:id]

		@topic.update_attributes(group_id: params[:group])

		redirect_to cpanel_topics_path
	end

end
