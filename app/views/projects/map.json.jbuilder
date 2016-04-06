json.name @project.title

json.children @project.sprints do |sprint|
  json.name sprint.title
  json.children sprint.tasks do |task|
    json.name task.title
    json.size 4000
    json.status task.aasm_state
  end
end
