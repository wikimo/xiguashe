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

  def web_nav(controller_name,action)
    html = ''

    if controller_name == 'groups' && action == 'discovery'
      html.concat(content_tag(:li,content_tag(:a ,'发现小组',:href => discovery_groups_path,:class => 'active')))
    else
      html.concat(content_tag(:li,content_tag(:a ,'发现小组',:href => discovery_groups_path)))
    end

    if controller_name == 'topics' && action == 'discovery'
      html.concat(content_tag(:li,content_tag(:a ,'发现话题',:href => discovery_topics_path,:class => 'active')))
    else
      html.concat(content_tag(:li,content_tag(:a ,'发现话题',:href => discovery_topics_path)))
    end
    raw html
  end
end  