module PhotosHelper

  def photo_choose_helper(photo)
      image_tag photo.path.url
  end

  def photo_choose_url_helper(photo)
      photo.path.url
  end

  def photo_tag_helper(path, options = {})
    options[:style] ||= :small
    style = case options[:style].to_s
            when "small" then "100x100"
            else options[:style].to_s
            end
    image_tag path.url(style)
  end

end
