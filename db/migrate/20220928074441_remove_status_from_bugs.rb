class RemoveStatusFromBugs < ActiveRecord::Migration[7.0]
  def change
    remove_column :bugs, :status
  end
end
