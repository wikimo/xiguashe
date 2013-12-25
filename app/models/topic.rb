# coding: utf-8
# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer          default(0)
#  username   :string(255)
#  hit_num    :integer          default(0)
#  reply_num  :integer          default(0)
#  state      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          default(0)
#  ip         :string(255)      default("")
#  like_num   :integer          default(0), not null
#  types      :integer          default(1)
#  score      :decimal(18, 5)   default(0.0)
#


class Topic < ActiveRecord::Base
	
	self.per_page = 10

	validates :title, :content, presence: true

	belongs_to :group
	
	belongs_to :user

	has_many :photos,   :as => :photoable,   :dependent => :destroy

	has_many :comments, :as => :commentable, :dependent => :destroy

	has_many :products, dependent: :destroy
	
	scope :order_by_created_at_desc, order('created_at DESC')

	scope :order_by_updated_at_desc, order('updated_at DESC')

	scope :order_by_reply_num_desc,  order('reply_num DESC')

	scope :order_by_score_desc, order('score DESC')

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
			self.order_by_score_desc.paginate(page: page, per_page: per_page)
		end

		def recommend_user_topic(ids, page = 1, per_page = 20)
			self.by_user_ids(ids).order_by_updated_at_desc.paginate(page: page, per_page: per_page)
		end

		def search_in_cpanel(search, page = 1, per_page = 20)
		 	if search
		 		where('title like ? ', "%#{search}%").order_desc_by_created_at(page, per_page)
		 	else
		 		order_desc_by_created_at(page, per_page)
		 	end
		end

	end
end
