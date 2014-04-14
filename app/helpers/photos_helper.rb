module PhotosHelper

  def photo_choose_helper(photo)
      image_tag photo_tag_helper(photo.path, style: :medium)
  end

  def photo_choose_url_helper(photo)
    photo_tag_helper(photo_path, style: :medium)
  end


  def photo_tag_helper(path, options = {})
    options[:style] ||= :small
    style = case options[:style].to_s
            when "small" then "100x100"
            when "medium" then "300x300"
            else options[:style].to_s
            end
    path.url(style)
  end

end
