def get_children(json, children)
  json.children children do |child|
    json.id child.id
    json.title child.title
    json.description child.description
    get_children(json, child.children)
  end
end

nodes = @tasks.where(task_id: nil)
json.root do
  json.id @sprint.id
  json.title @sprint.title
  json.description @sprint.description
  get_children(json, nodes)
end
