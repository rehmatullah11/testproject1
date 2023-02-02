class AddCreatorIdSolverIdToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :creator_id, :integer
    add_column :bugs, :solver_id, :integer
  end
end
