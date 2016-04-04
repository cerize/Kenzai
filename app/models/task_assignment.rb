class TaskAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  def self.find_record(user, sprint)
    result = TaskAssignment.where("user_id = ? and sprint_id = ?", user.id, sprint.id)
    if result == []
      nil
    else
      result[0]
    end
  end
end
