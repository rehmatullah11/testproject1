class Bug< ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :project_id }
  validates :bug_status, presence: true
  validates :bug_type, presence: true

  belongs_to :project 

  belongs_to :bug_creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :bug_solver, class_name: "User", foreign_key: "solver_id"


  enum bug_type: 
  {
    feature: 0,
    bug: 1
  }

end