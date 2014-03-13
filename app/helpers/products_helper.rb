module ProductsHelper

  def carousel_helper(photo, index)
 
    html = ""

    if index == 0
      html = content_tag(:div, class: 'item active') do
                photo_choose_helper(photo)
             end
    else
      html = content_tag(:div, class: 'item') do
                photo_choose_helper(photo)
             end
    end
    

    raw html

  end

end
