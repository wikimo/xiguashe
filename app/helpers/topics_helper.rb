module TopicsHelper

  def topic_photos_helper(topic)
    unless topic.img.nil? || topic.img.url.include?('blank')
      image_tag topic.img.url, alt: topic.title
    end
  end

  def create_user_only(item, &block)
    block.call if current_user && current_user.id == item.user.id 
  end

  def markdown(text)
    options = {   
        :autolink => true, 
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
      }

    markdown =  Redcarpet::Markdown.new(Redcarpet::Render::HTML,options)
    markdown.render(text).html_safe
  end

end
