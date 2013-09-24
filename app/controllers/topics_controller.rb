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

		@topic = @group.topics.create(params[:topic])

		@topic.ip = request.ip

		if @topic.save
			update_photos(params[:photo_id],@topic)
			
			@group.update_attributes({:topic_num => @group.topic_num + 1})

			update_products(params[:product_id], @topic)

			redirect_to topic_path(@topic), :notice => t(:create_success)
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

		params[:topic][:content] = content_filter(params[:topic][:content])

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
		
		@user_topics = @user.topics.order_by_created_at_desc.limit(5)
	end

	def new_product
		@product = Product.new
	end

	def create_product
    	url = URI.parse(params[:link])  

		if url.host.include? 'tb' or url.host.include? 'tmall'
			class_name = 'ProductTaobao'
		elsif url.host.include? 'paipai'
			class_name = 'ProductPaipai'      
		else
			puts 'error'
		end
		class_instance =  Object.const_get(class_name).new

		item  = class_instance.get_info  params[:link]

		item[:user_id] = current_user.id
		#item[:topic_id] = topic_id

		@product = Product.new item

		if @product.save
			@product
		else 
			nil
		end
    end


    def destroy_product
    	@product = Product.find(params[:product_id])

    	@product.destroy
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


	    
end