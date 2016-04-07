class Task < ActiveRecord::Base
  include AASM

  belongs_to :sprint
  belongs_to :node,     class_name: "Task", foreign_key: "task_id"
  has_many   :children, class_name: "Task", foreign_key: "task_id"
  has_many :task_assignments, dependent: :destroy
  has_many :users, through: :task_assignments

  validates :title, presence: true

  aasm whiny_transitions: false do
    state :created, initial: true
    state :in_progress
    state :complete

    event :start do
      transitions from: :created, to: :in_progress
    end

    event :finish do
      transitions from: [:in_progress, :created], to: :complete
    end

    event :go_back do
      transitions from: :in_progress, to: :created
    end

  end

end
