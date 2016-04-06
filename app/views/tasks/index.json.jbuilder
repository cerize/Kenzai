def get_children(json, children)
  json.children children do |child|
    json.id child.id
    json.title child.title
    json.description child.description
    json.aasm_state child.aasm_state
    json.on_task child.users.exists?(current_user)
    json.users child.users do |user|
      json.name user.full_name
    end
    get_children(json, child.children)
  end
end

nodes = @tasks.where(task_id: nil)
json.root do
  json.id @sprint.id
  json.title @sprint.title
  json.description @sprint.description
  json.aasm_state @sprint.aasm_state
  get_children(json, nodes)
end
