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
		

			day = (Time.new - likeable.created_at)  / (3600 * 24)

			score = ( 1 / (day + 2) ** 1.8 ).to_f

			self.likeable.update_attributes( { :score => likeable.score + score } )
		end
	
end
