class Snippet < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :title,       presence: true
  validates :description, presence: true

#check if this method is necessary
  def self.filter_project(project)
    where("project_id = ?", project.id)
  end

end
