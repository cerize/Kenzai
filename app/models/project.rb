class Project < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: 'user_id'

  has_many :project_assignments, dependent: :destroy
  has_many :members, through: :project_assignments, source: :user

  validates :title, presence: true
end
