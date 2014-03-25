#coding: utf-8
class ProductsController < ApplicationController

  before_filter :find_by_id, only: [:show, :destroy]

  def index
    @products = Product.short.includes(:user).order_by_created_at_desc.paginate(page: params[:page])
  end

  def show
    @comments = @product.comments.paginate(page: params[:page])
  end

  def get

    if validate_url(params[:link]) 
      render json: { text: 0, msg: t(:product_url_error) }

    else

      url = URI.parse(params[:link])
      if url.host.include? 'taobao' or url.host.include? 'tb' or url.host.include? 'tmal'
        class_name = 'ProductTaobao'
      elsif url.host.include? 'paipai'
        class_name = 'ProductPaipai'
      else
        render json: { text: 1, msg: t(:product_url_error) }
      end

      class_instance = Object.const_get(class_name).new

      item = class_instance.get_info params[:link]

      if is_exist(item[:really_id])
        render json: { text: 2, really_id: item[:really_id], msg: t(:product_already_exit) }
      else
        render json: { text: 3, item: item  }
      end

    end

  end
	
	def new

    @images = params[:images]
   
    @product = Product.new(title: params[:title], url: params[:url], price: params[:price], 
                           user_id: current_user.id, really_id: params[:really_id], source: params[:source]) 

	end

  def url


  end

  def exist

    @product = Product.by_really_id(params[:really_id]).first unless !params[:really_id]

    render json: { product: @product }

  end


	def create

    @product = Product.new params[:product]

    @product.img = params[:radio_img]

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

      p @product.photos
    end

    def is_exist(really_id)

      product = Product.by_really_id(really_id)

      product.present?
    
    end
  
    def validate_url(url)
      mat = /(http|https):\/\//.match(params[:link])
      mat.nil? 
    end
end
