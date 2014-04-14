# coding: utf-8
require 'carrierwave/processing/mini_magick'
# 在图片空间里面定义好的“缩略图版本名称”，以防止调用错误
IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(100x100, 300x300)
class ImageUploader < CarrierWave::Uploader::Base
  def store_dir
    date = "#{model.created_at.year}-#{model.created_at.month}-#{model.created_at.day}"
    "#{model.class.to_s.underscore}/#{mounted_as}/#{date}"
  end

  def default_url
    "http://img.xiguashe.com/blank.png#{version_name}"
  end

  # 覆盖 url 方法以适应“图片空间”的缩略图命名
  def url(version_name = "")
    @url ||= super({})
    version_name = version_name.to_s
    return @url if version_name.blank?
    if not version_name.in?(IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES)
      # 故意在调用了一个没有定义的“缩略图版本名称”的时候抛出异常，以便开发的时候能及时看到调错了
      raise "ImageUploader version_name:#{version_name} not allow."
    end
    [@url,version_name].join("!") # ! 作为“间隔标志符”
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if super.present?
      @name ||="#{SecureRandom.uuid}.#{file.extension.downcase}"
    end
  end

end
