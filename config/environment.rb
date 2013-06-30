#encoding:utf-8
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Xiguashe::Application.initialize!


require 'will_paginate'
#will_paginate custom label
#WillPaginate::ViewHelpers.pagination_options[:inner_window] = 0 # inner_window  控制显示当前页临近的多少个链接 ，默认是4
#WillPaginate::ViewHelpers.pagination_options[:outer_window] = 1 # outer_window 控制显示首/末页临近的多少个链接，默认是1

WillPaginate::ViewHelpers.pagination_options[:previous_label] = '« 上一页'
WillPaginate::ViewHelpers.pagination_options[:next_label] = '下一页 »'