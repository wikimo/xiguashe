#coding: utf-8

class ProductsController < ApplicationController

  include ProductsHelper

  before_filter :find_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.short.includes(:user).order_by_created_at_desc.limit(Product.per_page)
    @offset = Product.per_page
  end

  def scroll
    
    offset = params[:offset].nil? ? Product.per_page : params[:offset].to_i

    if Product.count <= offset

      render json: { text: 0 } 

    elsif Product.count > offset && Product.count - offset < Product.per_page

      limit = Product.count - offset 
      @products = Product.short.includes(:user).order_by_created_at_desc.limit(limit).offset(offset)
      
      user_imgs = get_user_img_list(@products)

      render json: { text: 1, products: @products, user_imgs: user_imgs, offset: Product.count }

    else

      @products = Product.short.includes(:user).order_by_created_at_desc.limit(Product.per_page).offset(offset)

      user_imgs = get_user_img_list(@products)
      render json: { text: 2, products: @products, user_imgs: user_imgs, offset: offset + Product.per_page }

    end
    
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

  def edit

  end

	def create

    @product = Product.new params[:product]

    if @product.save

      unless params[:image].nil?
        params[:image].each do |img|
          if img == params[:radio_img]
            photo = Photo.create(path: image_deal(img) ,photoable: @product, user_id: params[:product][:user_id], is_main: 1)
            @product.update_attributes(img: photo.path.url)
          else
            Photo.create(path: image_deal(img) ,photoable: @product, user_id: params[:product][:user_id], is_main: 0)
          end
        end
      end

      unless params[:photo_id].nil?
        update_photo(@product, params[:photo_id])

        params[:photo_path_url].each do |url|
          if url == params[:radio_img]
            @product.update_attributes(img: url)
          end
        end
      end

      redirect_to @product, notice: t(:create_success)

    else
      unless params[:photo_id].nil?
        @photos = Photo.find_by_ids(params[:photo_id])
      end

      @images = params[:image]

      render 'new'
    end

	end

  def update

    params[:product][:img] = params[:radio_img] 

    if @product.update_attributes(params[:product])

      unless params[:photo_id].nil?
        update_photo(@product, params[:photo_id])
      end

      redirect_to @product, notice: t(:update_success)

    else
      render 'edit'
    end
  end

	def destroy
		@product.destroy
    redirect_to products_path, notice: t(:delete_success)
	end

  private 
    def find_by_id
      @product = Product.find(params[:id])
    end

    def is_exist(really_id)

      product = Product.by_really_id(really_id)

      product.present?
    
    end
  
    def validate_url(url)
      mat = /(http|https):\/\//.match(params[:link])
      mat.nil? 
    end

    def get_user_img_list(products)
      user_imgs = []

      products.each do |product|
        user_imgs << (product.user.avatar.nil? ? 'avatar.jpg' : product.user.avatar.url('100x100'))
      end

      user_imgs
    end

end
