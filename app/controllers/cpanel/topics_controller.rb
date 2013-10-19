class Cpanel::TopicsController < Cpanel::ApplicationController


	def index
		@topics = Topic.search(params[:search],params[:page], Topic.per_page)
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		redirect_to cpanel_topics_path
	end
end
