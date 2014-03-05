module ProductsHelper

  def carousel_helper(index)

    index == 0 ? content_tag(:div, '', class: 'item active') : content_tag(:div, '', class: 'item')

  end

end
