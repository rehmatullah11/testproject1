class ChangeUsersToProjects < ActiveRecord::Migration[7.0]
  def change
    rename_table :users,:projects
  end
end
