require "digest/md5"

module Xiguashe
  module APIEntities
    class Activity < Grape::Entity
      expose :id, :title, :content, :created_at, :updated_at
    end
  end
end
