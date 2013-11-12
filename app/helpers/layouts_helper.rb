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

  def web_nav(controller_name,action)
    html = ''

    if controller_name == 'groups' && action == 'discovery'
      html.concat(content_tag(:li,content_tag(:a ,'小组',:href => discovery_category_groups_path(:category_id => 0),:class => 'active')))
    else
      html.concat(content_tag(:li,content_tag(:a ,'小组',:href => discovery_category_groups_path(:category_id => 0))))
    end

    if controller_name == 'recommend' && action == 'topic'
        html.concat(content_tag(:li,content_tag(:a ,'话题',:href => recommend_topic_path,:class => 'active')))
      else
        html.concat(content_tag(:li,content_tag(:a ,'话题',:href => recommend_topic_path)))
      end

    if current_user
      

      if controller_name == 'recommend' && action == 'user'
        html.concat(content_tag(:li,content_tag(:a ,'关注',:href => recommend_user_path,:class => 'active')))
      else
        html.concat(content_tag(:li,content_tag(:a ,'关注',:href => recommend_user_path)))
      end

    end
    
    #html.concat(content_tag(:li,content_tag(:a ,'百科')))
    
    #if controller_name == 'topics' && action == 'discovery'
    #  html.concat(content_tag(:li,content_tag(:a ,'发现话题',:href => discovery_topics_path,:class => 'active')))
    #else
    #  html.concat(content_tag(:li,content_tag(:a ,'发现话题',:href => discovery_topics_path)))
    #end
    raw html
  end

  def format_content(content,len = 150)
    truncate(content.gsub(/<.*?>|\302\240/,'').strip,:length => len, :truncate_string =>"...") if !content.nil?
  end

  def quote_string(s)
    s.gsub(/'/, '') # ' (for ruby-mode)
  end
end  