class Like < ActiveRecord::Base

	belongs_to :likeable, :polymorphic => true

	belongs_to :user

	after_create :increase_num_cache

	def increase_num_cache

		return if self.likeable.blank? or self.user.blank?
		
		self.likeable.update_attributes({:like_num => likeable.like_num + 1})

		change_topic_score
	end

	after_destroy :decrease_num_cache

	def decrease_num_cache

		return if self.likeable.blank? or self.user.blank?

		self.likeable.update_attributes({:like_num => likeable.like_num - 1})

		change_topic_score
	end


	private
		def change_topic_score

			hour = (Time.new - likeable.created_at) / (60 * 60)

			score = likeable.like_num / hour ** 1.8

			self.likeable.update_attributes(:score => score)
		end
	
end
