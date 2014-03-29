class Cpanel::TopicsController < Cpanel::ApplicationController

  before_filter :require_admin

  before_filter :find_by_id, only: [:show, :edit, :update, :destroy]

	def index
    @topics = Topic.search_in_cpanel(params[:search]).paginate(page: params[:page])
	end

	def show

	end

  def edit

  end

  def update
    if @topic.update_attributes(params[:topic])
      redirect_to cpanel_topic_path(@topic), notice: t(:update_success)
    end
  end

	def destroy
		@topic.destroy
		redirect_to cpanel_topics_path
	end


  private 

    def find_by_id(id)

      @topic = Topic.find(params[:id])

    end

end
