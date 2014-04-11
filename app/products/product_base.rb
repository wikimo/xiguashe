require 'net/http'  
require 'uri'  
require 'digest/md5'
require 'json'
require 'open-uri'

class ProductBase

  def image_parse(img_url)

    ext = img_url.split('.')
    upload = { filename: "tmp.#{ext.last}", tempfile: open(img_url) }

  end

end	
