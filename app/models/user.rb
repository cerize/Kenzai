class User < ActiveRecord::Base

  has_secure_password

  has_many :project_assignments, dependent: :destroy
  has_many :projects, through: :project_assignments
  has_many :task_assignments, dependent: :destroy
  has_many :tasks, through: :task_assignments
  has_many :created_projects, foreign_key: "user_id", class_name: "Project"
  has_many :snippets, dependent: :destroy
  has_many :mudas, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, length: {minimum: 6}

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end
#must create a test
  def self.search_by_email(q)
    where("email ILIKE ?", q)
  end

#must create a test
  def is_manager?(project)
    project_assignments.where("is_manager = ? and project_id = ?", true, project.id) != []
  end

end
