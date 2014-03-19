class Cpanel::ProductsController < Cpanel::ApplicationController

  before_filter :require_admin

	def index
    @products = Product.short.includes(:user).search_in_cpanel(params[:search]).paginate(page: params[:page])
	end

	def show
    @product = Product.find(params[:id])
	end

	def update
		
	end

	def destroy

	end

  def douban_syn

    url = URI.parse('http://dongxi.douban.com/shows/%E6%AF%8D%E5%A9%B4/')
    dongxi = ProductDouban.new
    products = dongxi.get_goods_list url

    products.each do |product|

      p = Product.new(title: product[:title], url: product[:url], price: product[:price],
                      source: 'douban', really_id: product[:id], user_id: current_user.id)
      
      if p.save
        product[:img].each do |img|
          Photo.create(photoable: p, user_id: current_user.id, source: img[:original])

          p.update_attributes(img: img[:original]) if img[:active] == 'main'
        end
      end
    end

    redirect_to cpanel_products_path, notice: t(:douban_syn_success)
  end
	
end
