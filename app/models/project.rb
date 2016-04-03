class Project < ActiveRecord::Base
  include AASM

  belongs_to :creator, class_name: "User", foreign_key: 'user_id'

  has_many :project_assignments, dependent: :destroy
  has_many :members, through: :project_assignments, source: :user
  has_many :sprints, dependent: :destroy
  has_many :snippets, dependent: :destroy
  has_many :mudas, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :in_progress
    state :complete
    state :overdue
    state :cancelled

    event :start do
      transitions from: :draft, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :complete
    end

    event :expire do
      transitions from: :in_progress, to: :overdue
    end

    event :cancel do
      transitions from: [:draft, :in_progress], to: :cancelled
    end
  end

end
