class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many   :user_stories, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: {scope: :project_id}
  validates :start_date, presence: true
  validates :end_date, presence: true



end
