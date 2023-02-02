class ChangeColumnTypeUsertype < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :usertype, :integer, default: 1
  end
end
