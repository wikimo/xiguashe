class PhotosController < ApplicationController

	before_filter :logined?

	def create

		@photo = Photo.new(path: params[:photo], user_id: current_user.id)
		if @photo.save
			render json: { text: 1, msg: 'ok', photo: @photo.path.url, id: @photo.id }
		else
			render json: { text: 0, msg: 'fail'}
		end
	end

	def destroy
		@photo = Photo.find(params[:id])

		@photo.destroy

    render json: { text: 1, msg: 'ok'}
	end

end
