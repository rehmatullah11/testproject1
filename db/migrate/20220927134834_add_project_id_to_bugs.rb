class AddProjectIdToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :project_id, :integer
  end
end
