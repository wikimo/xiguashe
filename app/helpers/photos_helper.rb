module PhotosHelper

  def photo_choose_helper(photo)

    if photo.source
      image_tag photo.source
    else
      image_tag photo.path.url
    end
  end

  def photo_tag_helper(path, options = {})
    options[:style] ||= :small
    style = case options[:style].to_s
            when "small" then "100x100"
            else options[:style].to_s
            end
    image_tag path.url(style)
  end

  def checked_helper(index)
    checked = index == 0 ? true : false
  end
end
