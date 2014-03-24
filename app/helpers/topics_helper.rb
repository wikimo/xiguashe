module TopicsHelper

  def topic_photos_helper(topic)
    unless topic.img.nil? || topic.img.url.include?('blank')
      #image_tag topic.photos.first.path.url(:original), alt: topic.title
      image_tag topic.img.url, :alt => topic.title
    end
  end
end
