class ProductsController < ApplicationController
	
	def new
		@product = Product.new
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
		@product = Product.find(params[:id])

		@product.destroy
	end
end
