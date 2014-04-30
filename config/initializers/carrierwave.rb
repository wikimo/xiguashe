CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "dev"
  config.upyun_password = 'public0601'
  config.upyun_bucket = "xiguashe"
  config.upyun_bucket_domain = "img.xiguashe.com"
end