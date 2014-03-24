module TopicsHelper

  def topic_photos_helper(topic)
    unless topic.img.nil?
      # image_tag topic.img.url(:original), alt: topic.title
      image_tag topic.img.url, :alt =>  topic.title
    end
  end
end
