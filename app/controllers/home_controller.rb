class HomeController < ApplicationController

  def index
    @topics = Topic.short.includes(:user).order_by_created_at_desc.limit(30)
    @products = Product.short.order_by_created_at_desc.limit(30)
  end

	def about
		
	end

	def contact
		
	end

	def links
		
	end
end
