# coding: utf-8
class AddTypeToTopic < ActiveRecord::Migration
  def change

  	#话题类型 1:常规话题 2：包含分享商品的话题，默认为1
    add_column :topics, :types, :integer, :default => 1

  end
end
