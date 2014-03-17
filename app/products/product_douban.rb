require "nokogiri"
require "open-uri"
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

    title = doc.css('.commodity-detail').attr('data-title')
    id = doc.css('.commodity-detail').attr('data-tid')

    product = Hash.new

    product[:title] = title
    product[:id] = id

    doc.css('.nav-image').each do |li|
      product[:img] = [ li.attr('data-original-url'), li.attr('data-large-url'), li.css('img').attr('src') ]
    end

    product

  end

  #the method is useless
  def get_product_id url
    uri = Addressable::URI.parse(url)

    id = uri.basename.gsub('/[.html]/', '')
  end
  
end
