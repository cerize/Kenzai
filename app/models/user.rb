class User < ActiveRecord::Base
  
  has_secure_password

  has_many :project_assignments, dependent: :nullify
  has_many :projects, through: :project_assignments
  has_many :created_projects, foreign_key: "user_id", class_name: "Project"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, length: {minimum: 6}

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end

end
