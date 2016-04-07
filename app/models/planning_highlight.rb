class PlanningHighlight < ActiveRecord::Base
  belongs_to :sprint

  validates :description, presence: true
end
