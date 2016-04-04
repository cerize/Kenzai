class Task < ActiveRecord::Base
  include AASM

  belongs_to :sprint

  belongs_to :node,     class_name: "Task", foreign_key: "task_id"
  has_many   :children, class_name: "Task", foreign_key: "task_id"

  aasm whiny_transitions: false do
    state :created, initial: true
    state :in_progress
    state :complete

    event :start do
      transitions from: :created, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :complete
    end
  end

end
