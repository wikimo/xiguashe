module TopicsHelper

  def topic_photos_helper(topic)
    unless topic.photos.empty?
      image_tag topic.photos.first.pic.url(:original), alt: topic.title
    end
  end
end
