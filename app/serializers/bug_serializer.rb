class BugSerializer < ActiveModel::Serializer
  attributes :id, :title, :project_id, :description, :screenshot, :deadline, :piece_status, :piece_type, :developer_ids, :qa_id
end
