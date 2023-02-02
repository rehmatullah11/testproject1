class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.string :status
      t.integer :bug_type,default: 1
      t.string :bug_status
      t.timestamps
    end
  end
end
