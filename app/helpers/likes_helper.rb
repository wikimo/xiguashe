# coding: utf-8
module LikesHelper



	def likeable_tag(likeable)
	    liked = false
	    icon = content_tag("i", "", :class => "icon small_like")
	    
	    if current_user
	      if Like.where(:likeable_type => likeable.class, :likeable_id => likeable.id, :user_id => current_user.id).count > 0
	        liked = true
	        icon = content_tag("i", "", :class => "icon small_liked")
	      end
	    end

	    like_label = raw  "#{icon} <span>#{likeable.like_num}人喜欢</span>"

	     if liked
	      link_to(like_label,"#",:title => "取消喜欢", 
	              'data-state' => 'liked','data-type' => likeable.class,'data-id' => likeable.id,
	              :class => "likeable", :onclick => "return LikeApp.likeable(this);")
	    else
	      link_to(like_label,"#",:title => "喜欢(可用于收藏此贴)", 
	              'data-state' => '', 'data-type' => likeable.class, 'data-id' => likeable.id,
	              :class => "likeable", :onclick => "return LikeApp.likeable(this);")
	    end
	 end

end
