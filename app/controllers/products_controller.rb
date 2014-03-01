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

    @images = item[:images]

    @product = Product.new 
    @product.title = item[:title]
    @product.url = item[:url]
    @product.price = item[:price]
    @product.user_id = current_user.id

	end

  def url

  end
	
	def create

    @product = Product.new params[:product]

    if @product.save
      p params[:photo]

      params[:photo].each do |p|
        Photo.create(pic: p, path: p, photoable: @product, user_id: params[:product][:user_id]) if p
      end

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
