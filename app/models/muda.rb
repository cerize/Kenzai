class Muda < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def self.filter_project(project)
    where("project_id = ?", project.id)
  end
  
end
