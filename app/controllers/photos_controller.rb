class PhotosController < ApplicationController
	before_filter :logined?
	def create
		@photo = Photo.new init_params(params)
		if @photo.save
			render :json  => {:text  => 1,:msg => 'ok',:photo  => @photo.path.url('100x100'),:id  => @photo.id}
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
		@photo = Photo.find(params[:id])

		# topic =  Topic.find(@photo.photoable_id)

		# topic.content = topic.content.gsub(/<img(.*?)#{@photo.pic_file_name}(.*?)>/,'')
		# p topic.content
		# topic.save
		
		@photo.destroy
	end

	private 
	    def init_params(params)
	      if params[:photo].nil? 
	        h = Hash.new 
	        h[:photo] = Hash.new 
	        h[:photo][:user_id] = params[:user_id] 
	        h[:photo][:pic] = params[:Filedata] 
	        h[:photo][:pic].content_type = MIME::Types.type_for(h[:photo][:pic].original_filename).first
	        h[:photo][:path] = params[:Filedata] 
	        h[:photo]
	      else 
	        params[:photo]
	      end 
	    end
end
