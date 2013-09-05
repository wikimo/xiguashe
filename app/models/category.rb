class Category < ActiveRecord::Base

	self.per_page = 30

	has_many :groups

	class << self

		def order_desc_by_created_at(page = 1, per_page = 30)
			self.order("created_at desc").paginate(:page => page, :per_page => per_page)
		end
	end

end
