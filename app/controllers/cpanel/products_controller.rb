#encoding: utf-8
class Cpanel::ProductsController < Cpanel::ApplicationController

  include ProductsHelper

  before_filter :require_admin

  before_filter :find_by_id, only: [:show, :edit, :show, :update, :destroy]

	def index
    @products = Product.short.includes(:user).search_in_cpanel(params[:search]).paginate(page: params[:page])
	end

	def show

	end

  def edit

  end

	def update

    if @product.update_attributes(params[:product])
      redirect_to cpanel_product_path(@product), notice: t(:update_success)
    end
		
	end

	def destroy

    @product.destroy

    redirect_to cpanel_products_path, notice: t(:delete_success)
	end

  def douban_syn

    url = URI.parse('http://dongxi.douban.com/shows/%E6%AF%8D%E5%A9%B4/')
    dongxi = ProductDouban.new
    products = dongxi.get_goods_list url

    products.each do |product|


      if find_product(product[:id], "douban").blank?

        p = Product.new(title: product[:title], url: product[:url], price: product[:price],
                        source: 'douban', really_id: product[:id], user_id: current_user.id, 
                        money_logo: product[:money_logo], appraisal: product[:appraisal])
      
        if p.save
          product[:img].each do |image|
            photo = Photo.create(photoable: p, user_id: current_user.id, path: image_deal(image[:original]))
            p.update_attributes(img: photo.path.url) if image[:active] == 'main'
          end
        end
      end
    end
    redirect_to cpanel_products_path, notice: t(:douban_syn_success)
  end


  private 

  def find_product(really_id, source)
    product = Product.by_really_id(really_id).by_source(source).first
  end

  def find_by_id
    @product = Product.find(params[:id])
  end

	
end
