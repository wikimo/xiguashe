class ProductsController < ApplicationController

  before_filter :find_by_id, only: [:show, :destroy]

  def index
    @products = Product.short.includes(:user).order_by_created_at_desc.paginate(page: params[:page])
  end

  def show

    @comments = @product.comments.paginate(page: params[:page])
  end
	
	def new
    url = URI.parse(params[:link])
    if url.host.include? 'taobao' or url.host.include? 'tb' or url.host.include? 'tmal'
      class_name = 'ProductTaobao'
    elsif url.host.include? 'paipai'
      class_name = 'ProductPaipai'
    else
      puts 'error'
    end

    class_instance = Object.const_get(class_name).new

    item = class_instance.get_info params[:link]
    item[:user_id] = current_user.id

    @product = Product.new item
	end

  def url

  end
	
	def create
		url = URI.parse(params[:link])  

		if url.host.include? 'taobao' or url.host.include? 'tb' or url.host.include? 'tmall'
			class_name = 'ProductTaobao'
		elsif url.host.include? 'paipai'
			class_name = 'ProductPaipai'      
		else
			puts 'error'
		end
		class_instance =  Object.const_get(class_name).new

		item  = class_instance.get_info  params[:link]
		item[:user_id] = current_user.id

		@product = Product.new item

		if @product.save
			@product
		else
			nil
		end
	end

	def destroy
		@product.destroy
	end

  private 
    def find_by_id
      @product = Product.find(params[:id])
    end
end
