class Topic < ActiveRecord::Base
	self.per_page = 10

	belongs_to :group
	
	belongs_to :user

	has_many :comments, :as => :commentable, :dependent => :destroy

	searchable	do
		text :title, :content
	end



	class << self

		def like_topics(today, topic_ids)
			Topic.find(:all,:conditions => ['created_at >= ? and created_at <=? and id not in(?)',(today - 7),(today + 1),topic_ids],:limit => 10,:order => 'like_num desc, id desc')
		end


		def recent_topics
			Topic.find(:all,:limit => 2,:order =>'id desc')
		end


		def order_by_reply_num
			Topic.find(:all, :order => 'reply_num desc')
		end

	end
end
