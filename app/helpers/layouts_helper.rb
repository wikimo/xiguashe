#encoding:utf-8
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

  def li_css(index,pre = 2,cls="last-item")
    html  =  (index + 1) % pre == 0 ?  "<li class='#{cls}'>" : '<li>'
    raw html
  end

  def format_content(content,len = 150)
    truncate(content.gsub(/<.*?>|\302\240/,'').strip,:length => len, :truncate_string =>"...") if !content.nil?
  end

  def quote_string(s)
    s.gsub(/'/, '') # ' (for ruby-mode)
  end
end  
