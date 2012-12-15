class Topic < ActiveRecord::Base
	
	belongs_to :group
	
	belongs_to :user

	has_many :comments, :as => :commentable, :dependent => :destroy

	searchable	do
		text :title, :content
	end
end
