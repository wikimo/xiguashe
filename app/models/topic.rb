class Topic < ActiveRecord::Base
	self.per_page = 30

	belongs_to :group
	
	belongs_to :user

	has_many :comments, :as => :commentable, :dependent => :destroy
	
	scope :order_by_created_at, order("created_at desc")

	searchable	do
		text :title, :content
	end



	class << self

		def like_topics(topic_ids)
		  	#this sql is error
			Topic.find(:all,:conditions => ['created_at >= ? and id not in(?)',7.day.ago,topic_ids],:limit => 10,:order => 'like_num desc, id desc')
		end

		def recent_topics
			Topic.find(:all,:limit => 2,:order =>'id desc')
		end


		def order_by_reply_num
			Topic.find(:all, :order => 'reply_num desc')
		end

		def order_desc_by_created_at(page = 1, per_page = 20)
			Topic.order("created_at DESC").paginate(:page => page, :per_page => per_page)
		end

		def discovery(page = 1,per_page = 20)
			Topic.order('updated_at desc, reply_num desc').paginate(:page => page,:per_page => per_page )
		end

	end
end
