class Sprint < ActiveRecord::Base
  include AASM

  belongs_to :project
  has_many   :user_stories,        dependent: :destroy
  has_many   :tasks,               dependent: :destroy
  has_many   :comments,            dependent: :destroy
  has_many   :planning_highlights, dependent: :destroy
  has_many   :review_highlights,   dependent: :destroy
  has_many   :task_assignments,    dependent: :destroy
  has_many   :users,               through: :task_assignments

  validates :title, presence: true,
                    uniqueness: {scope: :project_id}
  validates :start_date, presence: true
  validates :end_date, presence: true

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :in_progress
    state :complete

    event :start do
      transitions from: :draft, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :complete
    end
  end

end
