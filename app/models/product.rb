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

  self.per_page = 30

  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
  
  has_many :photos, as: :photoable, dependent: :destroy

  scope :short, select: "id, title, url, img, price, source,appraisal, user_id, created_at"

	scope :order_by_created_at_desc, order('created_at DESC')

  scope :by_really_id, lambda { |really_id| where('really_id = ?', really_id) }

  scope :by_source, lambda { |source| where('source = ?', source) }

	searchable	do
		text :title
	end

	class << self

		def search_in_cpanel(search)
			if search 
				where('title like ?', "%#{search}%").order_by_created_at_desc
      else
        order_by_created_at_desc
			end
		end
	end
end
