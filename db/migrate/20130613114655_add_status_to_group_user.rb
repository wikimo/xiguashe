class AddStatusToGroupUser < ActiveRecord::Migration
  def change
  	#status 0：没有申请， 1：申请中， 2：审核通过, 3: 审核不通过再次提交状态置为1,  默认为0
  	add_column :group_users, :status, :integer, :default => 0
  end
end
