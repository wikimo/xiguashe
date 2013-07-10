class PhotosController < ApplicationController

	def create
		@photo = Photo.new init_params(params)
		if @photo.save
			render :json  => {:text  => 1,:msg => 'ok',:photo  => @photo.pic.url(:thumb),:id  => @photo.id}
		else
			render :json => {:text  => 0,:msg => 'fail'}
		end
	end

	# def update
	# 	@photo =  Photo.find(params[:id])
	# 	if @photo.update_attributes(params[:photo])
	# 		render :text => true
	# 	else
	# 		render :text => false
	# 	end
	# end

	def destroy
		photo = Photo.find(params[:id])
		photo.destroy
	end

	private 
	    def init_params(params)
	      if params[:photo].nil? 
	        h = Hash.new 
	        h[:photo] = Hash.new 
	        h[:photo][:user_id] = params[:user_id] 
	        h[:photo][:pic] = params[:Filedata] 
	        h[:photo][:pic].content_type = MIME::Types.type_for(h[:photo][:pic].original_filename).to_s
	        h[:photo]
	      else 
	        params[:photo]
	      end 
	    end
end
