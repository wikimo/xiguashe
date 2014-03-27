module TopicsHelper

  def topic_photos_helper(topic)
    unless topic.img.nil? || topic.img.url.include?('blank')
      topic.img.url
    end
  end

end
