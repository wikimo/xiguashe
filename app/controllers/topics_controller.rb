class TopicsController < ApplicationController

    before_filter :logined?, :except => [:index, :show, :discovery]
    before_filter :find_topic, :only => [:edit,:update,:show]

	def index
		@topics = Topic.short.includes(:user).order_by_created_at_desc.paginate(:page => params[:page])
	end

	def discovery
		@topics = Topic.discovery(params[:page], Topic.per_page)
	end


	def new

	end

	def create

		@topic = Topic.create(params[:topic])

		@topic.ip = request.ip

		if @topic.save
			update_photos(params[:photo_id],@topic)

			redirect_to topic_path(@topic), :notice => t(:create_success)
		else
			render 'new'
		end

	end

	def edit
		@group = @topic.group
	end

	def update
		params[:topic][:content] = content_filter(params[:topic][:content])

		if @topic.update_attributes(params[:topic])
			update_photos(params[:photo_id],@topic)
			update_products(params[:product_id], @topic)
			redirect_to @topic, :notice => t(:update_success)
		else
			#error
		end
	end

	def show
		@topic.update_attributes({:hit_num => @topic.hit_num + 1})
		@comments = @topic.comments.paginate(page:params[:page])
	end

	private

	    def update_photos (photo_id,topic)
	      photo_id  && photo_id.each do |id|
	        Photo.find(id).update_attributes!(:photoable  => topic)
	      end
	    end

	    def update_products(product_id, topic)
	    	product_id && product_id.each do |id|
	    		Product.find(id).update_attributes!(topic_id: topic.id)
	    	end
	    end

	    def content_filter(content)
	    	substitute = '\r\n';
			content = content.gsub(/^[#{substitute}]+|[#{substitute}]+$/, '').gsub(/\r\n/,"<br/>")
	    end

	    def find_topic
	    	@topic =  Topic.where(:id => params[:id]).first

      	render_404 if @topic.nil?
	    end

end
