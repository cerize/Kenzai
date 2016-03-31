class ProjectAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, :project_id, presence: true
  validates :user_id, uniqueness: {scope: :project_id}

  def self.find_record(user, project)
    result = ProjectAssignment.where("user_id = ? and project_id = ?", user.id, project.id)
    if result == []
      nil
    else
      result[0]
    end
  end

  def self.set_as_manager(user, project)
    project_assignment =  ProjectAssignment.find_record(user, project)
    if project_assignment
      project_assignment.is_manager = true
      project_assignment.save
    end
  end

  def self.remove_manager(user, project)
    project_assignment =  ProjectAssignment.find_record(user, project)
    if project_assignment
      project_assignment.is_manager = false
      project_assignment.save
    end
  end


end
