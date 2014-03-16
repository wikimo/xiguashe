require "nokogiri"
require "open-uri"

class ProductDouban < ProductBase

  def get_goods_list url
    return 'goods_url_nil' if url.nil?

    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'

    a = []
    if url.host.include? 'dongxi'

      doc.css('.card-main .card-hd a').each do |a|
        url = a.attr('href')
        p "url: " + url
      end

        
    end
  end
  
end
