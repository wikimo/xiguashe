class Topic < ActiveRecord::Base
	
	belongs_to :group
	
	belongs_to :user

	has_many :comments, :dependent => :destroy
end
