module HomeHelper


  def item_active_for(index, &block)

    css_class = index == 0 ? 'item active' : 'item'

    content_tag(:div, class: css_class, &block)
    
  end

  def carousel_for index

    if index == 0
      content_tag(:li, '', class: 'active', 'data-target' => "#carousel-example", 'data-slide-to' => index)
    else
      content_tag(:li, '', 'data-target' => "#carousel-example", 'data-slide-to' => index)
    end
    
  end
end
