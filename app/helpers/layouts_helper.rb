module LayoutsHelper
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end 

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def li_with_style(index,cls="nm")
  	html  = index % 2 == 0 ? '<li>' : "<li class='#{cls}'>"
  	raw html
  end
end  