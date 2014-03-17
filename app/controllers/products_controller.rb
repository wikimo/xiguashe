class ProductsController < ApplicationController

  before_filter :find_by_id, only: [:show, :destroy]

  def index
    @products = Product.short.includes(:user).order_by_created_at_desc.paginate(page: params[:page])
  end

  def show

    @comments = @product.comments.paginate(page: params[:page])
  end
	
	def new

    if !validate_url(params[:link])

      redirect_to url_products_path, notice: t(:product_url_error)

    else

      url = URI.parse(params[:link])
      if url.host.include? 'taobao' or url.host.include? 'tb' or url.host.include? 'tmal'
        class_name = 'ProductTaobao'
      elsif url.host.include? 'paipai'
        class_name = 'ProductPaipai'
      else
        redirect_to url_products_path, notice: t(:no_product_url)
      end

      class_instance = Object.const_get(class_name).new

      item = class_instance.get_info params[:link]

      if is_exit(item[:really_id])
        redirect_to "/products/url?really_id=#{item[:really_id]}", notice: t(:product_already_exit) 
      end

      @images = item[:images]
    
      @product = Product.new(title: item[:title], url: item[:url], price: item[:price], 
                             user_id: current_user.id, really_id: item[:really_id], source: item[:source]) 

    end
	end

  def url

    @product = Product.by_really_id(params[:really_id]).first unless !params[:really_id]

  end

  def test
    url = URI.parse('http://dongxi.douban.com/shows/%E6%AF%8D%E5%A9%B4/')
    dongxi = ProductDouban.new
    products = dongxi.get_goods_list url

    products.each do |product|
      puts product[:title] 
      puts product[:id]
    end
  end
	
	def create

    @product = Product.new params[:product]

    if @product.save

      unless params[:image].nil?
        params[:image].each do |img|
          Photo.create(source: img, photoable: @product, user_id: params[:product][:user_id])
        end
      end

      unless params[:photo_id].nil?
        update_photo(@product, params[:photo_id])
      end


      redirect_to @product, notice: t(:create_success)

    end

	end

	def destroy
		@product.destroy
	end

  private 
    def find_by_id
      @product = Product.find(params[:id])
    end

    def is_exit(really_id)

      product = Product.by_really_id(really_id)

      product.present?
    
    end
  
    def validate_url(url)
      mat = /(http|https):\/\//.match(params[:link])
      mat.blank? ? false : true
    end
end
