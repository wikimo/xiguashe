class Topic < ActiveRecord::Base
	self.per_page = 30

	belongs_to :group
	
	belongs_to :user

	has_many :photos,   :as => :photoable,   :dependent => :destroy

	has_many :comments, :as => :commentable, :dependent => :destroy
	
	scope :order_by_created_at_desc, order('created_at DESC')

	scope :order_by_updated_at_desc, order('updated_at DESC')

	scope :order_by_reply_num_desc,  order('reply_num DESC')

	scope :by_user_ids,  lambda { |ids| where('user_id in (?)', ids) }

	searchable	do
		text :title, :content
	end

	class << self

		def like_topics(topic_ids)
		  	#this sql is error
			self.find(:all,:conditions => ['created_at >= ? and id not in(?)',7.day.ago,topic_ids],:limit => 10,:order => 'like_num desc, id desc')
		end

		def recent_topics
			self.find(:all,:limit => 2,:order =>'id desc')
		end

		def order_desc_by_created_at(page = 1, per_page = 20)
			self.order_by_created_at_desc.paginate(:page => page, :per_page => per_page)
		end

		def discovery(page = 1,per_page = 20)
			self.order_by_updated_at_desc.order_by_reply_num_desc.paginate(:page => page,:per_page => per_page )
		end

		def recommend(page = 1, per_page = 20)
			self.order_by_updated_at_desc.order_by_reply_num_desc.paginate(page: page, per_page: per_page)
		end

		def recommend_user_topic(ids, page = 1, per_page = 20)
			self.by_user_ids(ids).order_by_updated_at_desc.paginate(page: page, per_page: per_page)
		end

	end
end
