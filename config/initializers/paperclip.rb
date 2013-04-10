# encoding:utf-8
Paperclip.interpolates :month_partition  do |attachment, style|
 # Time.now.strftime("%Y/%m%d")
  attachment.instance_read(:updated_at).strftime("%Y/%m%d/")
end