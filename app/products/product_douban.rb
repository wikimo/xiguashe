#encoding: utf-8
require "nokogiri"
require "addressable/uri"

class ProductDouban < ProductBase

  def get_goods_list url
    return 'goods_url_nil' if url.nil?

    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'

    if url.host.include? 'dongxi'

      products = []

      doc.css('.card-main .card-hd a').each do |a|
        product_url = a.attr('href')

        products << product_info(product_url)
      end

    end

    products

  end

  def product_info url

    return 'product_url_nil' if url.nil?

    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'

    title = doc.css('.commodity-detail').attr('data-title').value()
    id = doc.css('.commodity-detail').attr('data-tid').value()
    price_content = doc.css('.commodity-detail').css('.commodity-price').children().text().chomp.strip

    url = doc.css('.J_PurchaseBtn').attr('href').value()


    if doc.css('.postitem-main')[0].nil? 
      appraisal = "此商品无评价"
    else
      appraisal = doc.css('.postitem-main').css('.quote').text()
    end


    if price_content[0,1] == 'U'
      money_logo = price_content[0,3]
      price = price_content[4, price_content.length]
    else
      money_logo = price_content[0,1]
      price = price_content[1, price_content.length]
    end


    product = {
      title: title,
      id: id,
      url: url,
      price: price.gsub(/,/, ''),
      money_logo: money_logo,
      appraisal: appraisal
    }

    product[:img] = []

    doc.css('.nav-image').each_with_index do |li, i|

      active = (i == 0 ? 'main' : 'unmain')

      img = {

        original: li.attr('data-original-url'),
        large: li.attr('data-large-url'),
        small: li.css('img').attr('src').value(),
        active: active

      } 

      product[:img] << img
    end

    puts product[:title]

    product

  end

  #the method is useless
  def get_product_id url
    uri = Addressable::URI.parse(url)

    id = uri.basename.gsub('/[.html]/', '')
  end
  
end
