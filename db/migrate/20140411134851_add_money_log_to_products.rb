#encoding: utf-8
class AddMoneyLogToProducts < ActiveRecord::Migration
  def change
    add_column :products, :money_logo, :string, default: '¥'
  end
end
