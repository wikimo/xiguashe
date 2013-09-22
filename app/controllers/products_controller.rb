class ProductsController < ApplicationController
	def new
		
	end
	
	def create
		url = URI.parse(params[:link])  

		if url.host.include? 'tb' or url.host.include? 'tmall'
			class_name = 'ProductTaobao'
		elsif url.host.include? 'paipai'
			class_name = 'ProductPaipai'      
		else
			puts 'error'
		end
		class_instance =  Object.const_get(class_name).new

		item  = class_instance.get_good_info  params[:link]

	end
end
