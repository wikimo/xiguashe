# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  is_use      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ActiveRecord::Base

	self.per_page = 30

	has_many :groups

	class << self

		def order_desc_by_created_at(page = 1, per_page = 30)
			self.order("created_at desc").paginate(:page => page, :per_page => per_page)
		end
	end

end
