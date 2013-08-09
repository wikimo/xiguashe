class Like < ActiveRecord::Base

	belongs_to :likeable, :polymorphic => true

	belongs_to :user

	after_create :increase_num_cache

	def increase_num_cache

		return if self.likeable.blank? or self.user.blank?
		
		self.likeable.update_attributes({:like_num => likeable.like_num + 1})

	end

	after_destroy :decrease_num_cache

	def decrease_num_cache

		return if self.likeable.blank? or self.user.blank?

		self.likeable.update_attributes({:like_num => likeable.like_num - 1})

	end
	
end
