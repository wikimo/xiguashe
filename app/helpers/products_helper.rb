
module ProductsHelper

  def product_carousel_for(index)
    if index == 0
      content_tag :li, '', class: 'active', 'data-target' => "#carousel-example-generic", 'data-slide-to' => index
    else
      content_tag :li, '', 'data-target' => "#carousel-example-generic", 'data-slide-to' => index
    end
  end


  def product_photo_carousel_for(index, &block)

    css_class = index == 0 ? 'item active' : 'item'

    html = content_tag(:div, class: css_class, &block)

  end


  def checked_helper_2(photo, img)

     checked = photo_choose_url_helper(photo) == img ? true : false

  end

  def checked_helper(index)
    checked = index == 0 ? true : false
  end

  def image_deal(img_url)
    base = ProductBase.new
    base.image_parse(img_url)
  end

  def product_img_helper(img)

    image_tag "#{img}!300x300", alt: ''

  end


end
