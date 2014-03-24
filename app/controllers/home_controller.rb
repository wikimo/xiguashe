class HomeController < ApplicationController

  def index
    @topics = Topic.short.includes(:user).order_by_created_at_desc.limit(2)

    @products = Product.short.includes(:user).order_by_created_at_desc.limit(30)
  end

	def about
		
	end

	def contact
		
	end

	def links
		
	end
end
