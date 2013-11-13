class Product < ActiveRecord::Base

	belongs_to :topic

	scope :order_by_created_at_desc, order('created_at DESC')

	class << self
		
		def order_desc_by_created_at(page = 1, per_page = 20)
			self.order_by_created_at_desc.paginate(:page => page, :per_page => per_page)
		end

		def search_in_cpanel(search, page = 1, per_page = 20)
			if search 
				where('title like ?', "%#{search}%").order_desc_by_created_at(page, per_page)
			else
				order_desc_by_created_at(page, per_page)
			end
		end
	end
end
