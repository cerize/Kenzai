class Sprint < ActiveRecord::Base
  include AASM

  belongs_to :project
  has_many   :user_stories, dependent: :destroy

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
