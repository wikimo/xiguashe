class AddAppraisalToProducts < ActiveRecord::Migration
  def change
    add_column :products, :appraisal, :text
  end
end
