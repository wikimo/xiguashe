require "addressable/uri"

class ProductTaobao < ProductBase
	
	def initialize
		#@url = URI.parse('http://gw.api.tbsandbox.com/router/rest')
		@url = URI.parse('http://gw.api.taobao.com/router/rest')
		#@app_secret = 'sandbox36ed58b7ae4e991eb091cb6c2' 
		@app_secret = '648d7800f2ab5060174e9b06ef594b10' 
	end

	def get_info url
		item = get_item url

		# shop = get_shop item[:nick]

		# if !item.nil? and !shop.nil?
		# 	item.merge shop
		# end
	end


	#url: http://item.tbsandbox.com/item.htm?id=1500010992719&spm=2014.1021035540.0.0
	def get_item url
		num_iid =  get_id(url)
    
    promotion_hash = get_item_promotion num_iid
		params = { 
			'method' => 'taobao.item.get',
			'timestamp' => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
			'format' => 'json', 
			'app_key' => '21627701', 
			'v' => '2.0',
			'sign_method' => 'md5',
			'num_iid' => num_iid,
			'fields' => 'num_iid,title,desc,price,pic_url,detail_url,nick'
		}

		params["sign"] = Digest::MD5.hexdigest( @app_secret + params.sort.flatten.join + @app_secret).upcase

		resp  = Net::HTTP.post_form(@url, params)
		json  =JSON.parse(resp.body)
		# p json
		if !json['item_get_response'].nil?
			item = json['item_get_response']['item']

			item_hash = {
				:key => 'tb_' + num_iid,
				:title => item['title'],
  				:price => item['price'],
  				:img => item['pic_url'],
  				:url => item['detail_url'],
  				:descrip => item['desc'],
  				:nick => item['nick'],
          :promo_price => promotion_hash[:promo_price]
      }
		end

		item_hash	
	end

  def get_item_promotion item_id

    params = {
      'method' => 'taobao.ump.promotion.get',
      'timestamp' => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
      'format' => 'json',
      'app_key' => '21627701',
      'v' => '2.0',
      'sign_method' => 'md5',
      'item_id' => item_id
    }

		params["sign"] = Digest::MD5.hexdigest( @app_secret + params.sort.flatten.join + @app_secret).upcase

		resp  = Net::HTTP.post_form(@url, params)
		json  =JSON.parse(resp.body)
    
    if !json['ump_promotion_get_response'].nil?
        promotion = json['ump_promotion_get_response']['promotions']['promotion_in_item']
        promotion_hash = {
          :promo_price => promotion['promotion_in_item'][0]['item_promo_price'],
        }
    end

    promotion_hash

  end

	def get_shop nick
		params = { 
			'method' => 'taobao.shop.get',
			'timestamp' => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
			'format' => 'json', 
			'app_key' => '1021035540', 
			'v' => '2.0',
			'sign_method' => 'md5',
			'fields' => 'sid,title,nick',
			'nick' => nick
		}

		params["sign"] = Digest::MD5.hexdigest( @app_secret + params.sort.flatten.join + @app_secret).upcase

		resp  = Net::HTTP.post_form(@url, params)
		json  =JSON.parse(resp.body)

		if !json['shop_get_response'].nil?
			shop = json['shop_get_response']['shop']

			shop_hash = {
				:shop_title => shop['title'],
				:nick => shop['nick'],
  				#:shop_url => "http://shop"+shop['sid'].to_s+".taobao.com",
  				:shop_url => "http://mini.tbsandbox.com/seller/shop_detail.htm?nick=#{nick}"
  				}
		end

		shop_hash
	end

	def get_id url
		#p url
		uri = Addressable::URI.parse(url)
		params = uri.query_values
		#p params
		id =   params.has_key?('id') ? params['id'] : 0
	end

	def get_key url
		id =  'tb' + get_id(url)
	end


end

# share_taobao =  ShareTaobao.new
# item =  share_taobao.get_item 1500010992718


