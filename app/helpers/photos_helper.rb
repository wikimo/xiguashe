# encoding:utf-8
module PhotosHelper

  def photo_choose_helper(photo)
      image_tag photo_tag_helper(photo.path, style: :medium)
  end

  def photo_choose_url_helper(photo)
    photo_tag_helper(photo.path, style: :medium)
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

  def convert_product_url(url)
    if url.include?('taobao') || url.include?('tmall')
      id = url.split('id=').last
      return raw "<a data-type='0' biz-itemid='#{id}' data-rd='2' data-style='2'  href='#{url}' class='btn btn-primary' data-tmplid='1111' target='_blank'>去购买</a>"
    end

    link_to '去购买', url, class: "btn btn-primary",target: '_blank'
  end

end
