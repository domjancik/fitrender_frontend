json.array!(@jobs) do |job|
  json.extract! job, :id, :id_remote, :state
  json.url job_url(job, format: :json)
end
