module ProductsHelper

  def carousel_helper(photo, index)

    html = ""

    if index == 0
      html = content_tag(:div, class: 'item active') do
                photo_tag_helper(photo.path, style: :small)
             end
    else
      html = content_tag(:div, class: 'item') do
                photo_tag_helper(photo.path, style: :small)
             end
    end
    

    raw html

  end

end
