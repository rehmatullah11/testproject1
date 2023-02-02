class AddCreatorIdToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :creator_id, :integer
  end
end
