module PhotosHelper

  def photo_choose_helper(photo)

    if photo.taobao_img
      image_tag photo.taobao_img
    else
      photo_tag_helper(photo.path, style: :small)
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
end
