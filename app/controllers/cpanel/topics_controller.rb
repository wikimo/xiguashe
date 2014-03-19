class Cpanel::TopicsController < Cpanel::ApplicationController


	def index
	end

	def show
		@topic = Topic.find(params[:id])
	end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
  end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		redirect_to cpanel_topics_path
	end


end
