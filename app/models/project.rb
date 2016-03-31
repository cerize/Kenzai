class Project < ActiveRecord::Base
  # include AASM

  belongs_to :creator, class_name: "User", foreign_key: 'user_id'

  has_many :project_assignments, dependent: :destroy
  has_many :members, through: :project_assignments, source: :user
  has_many :sprints, dependent: :destroy
  has_many :snippets, dependent: :destroy
  has_many :mudas, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end
