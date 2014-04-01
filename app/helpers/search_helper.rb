#encoding:utf-8
module SearchHelper

  def search_nav_helper(action, params)
    html = ""

    if action == 'topics'
      html.concat(content_tag :li, content_tag(:a, '文章', href: "/search/topics?query=#{params}", 'data-toggle' => "tab"), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '文章', href: "/search/topics?query=#{params}"))
    end

    if action == 'products'
      html.concat(content_tag :li, content_tag(:a, '东西', href: "/search/products?query=#{params}", 'data-toggle' => "tab"), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '东西', href: "/search/products?query=#{params}"))
    end  

    raw html
  end
end
