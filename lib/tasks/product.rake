
namespace :douban do

  desc "douban async"
  task async: :environment do
      include ProductsHelper
      puts "sync start"
      default_url = 'http://dongxi.douban.com/shows/%E6%AF%8D%E5%A9%B4/'
      if ENV['start'].nil? || ENV['t'].nil?
        url = URI.parse(default_url)
      else
        page_url = default_url + "?start=#{ENV['start']}&_t=#{ENV['t']}"
        url = URI.parse(page_url)
      end

      dongxi = ProductDouban.new
      products = dongxi.get_goods_list url

      products.each do |product|

        if find_product(product[:id], "douban").blank?

          p = Product.new(title: product[:title], url: product[:url], price: product[:price],
                          source: 'douban', really_id: product[:id], user_id: User.get_random_admin.id, 
                          money_logo: product[:money_logo], appraisal: product[:appraisal])
        
          if p.save
            product[:img].each do |image|
              photo = Photo.create(photoable: p, user_id: User.get_random_admin.id, path: image_deal(image[:original]), is_main: image[:active] == 'main'? 1 : 0 )
              p.update_attributes(img: photo.path.url) if image[:active] == 'main'
            end
          end
        end
      end

      p "sync end! success!" 
  end

  def find_product(really_id, source)
    product = Product.by_really_id(really_id).by_source(source).first
  end

end
