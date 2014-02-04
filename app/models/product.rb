# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  descrip     :text
#  url         :string(255)
#  img         :string(255)
#  user_id     :integer
#  source      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#  key         :string(255)
#  price       :decimal(18, 2)   default(0.0)
#  nick        :string(255)
#  promo_price :decimal(18, 2)   default(0.0)
#

class Product < ActiveRecord::Base

  belongs_to :user

  scope :short, select: "id, title, url, img, created_at"

	scope :order_by_created_at_desc, order('created_at DESC')

	class << self
		
		def search_in_cpanel(search, page = 1, per_page = 20)
			if search 
				where('title like ?', "%#{search}%").order_desc_by_created_at(page, per_page)
			else
				order_desc_by_created_at(page, per_page)
			end
		end
	end
end
