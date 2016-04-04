class Task < ActiveRecord::Base
  belongs_to :sprint

  belongs_to :node,     class_name: "Task", foreign_key: "task_id"
  has_many   :children, class_name: "Task", foreign_key: "task_id"

end
