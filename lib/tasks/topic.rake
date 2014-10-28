namespace :topic do

  desc "convert markdown to html"
  task to_html: :environment do
    include TopicsHelper
    topics = Topic.all
    topics.each do |t|
      t.update_attributes({content: markdown(t.content)})
    end  
  end
end    