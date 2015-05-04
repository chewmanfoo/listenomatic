json.array!(@dpoints) do |dpoint|
  json.extract! dpoint, :id, :timestamp, :app_name, :pipeline_id, :pipeline_instance_id, :sabre_phase, :task, :trended_metrics, :tags
  json.url dpoint_url(dpoint, format: :json)
end
