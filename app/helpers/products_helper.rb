module ProductsHelper

  def topic_carousel_for(index)
    if index == 0
      content_tag :li, '', class: 'active', 'data-target' => "#carousel-example-generic", 'data-slide-to' => index
    else
      content_tag :li, '', 'data-target' => "#carousel-example-generic", 'data-slide-to' => index
    end
  end


  def product_carousel_for(index, &block)

    css_class = index == 0 ? 'item active' : 'item'

    html = content_tag(:div, class: css_class)

  end

end
