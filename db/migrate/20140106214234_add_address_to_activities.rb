class AddAddressToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :address, :string
    add_column :activities, :activity_ended_at, :datetime

  end
end
