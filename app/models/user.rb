class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :name, presence: true

  #many to many relation between users and projects

  has_many :user_projects, dependent: :destroy
  has_many :assigned_projects, through: :user_projects, source: :project, dependent: :destroy

  #one to many relation between users and projects

  has_many :created_projects,class_name: "Project", foreign_key: "creator_id", dependent: :destroy

  #two one to many relations between user and bugs

  has_many :created_bugs, class_name: "Bug", foreign_key: "creator_id", dependent: :destroy
  has_many :solved_bugs, class_name: "Bug", foreign_key: "solver_id", dependent: :destroy

  has_many :bugs, through: :created_projects

  enum usertype: 
  {
    manager: 0,
    developer: 1,
    qa: 2
  }

end
