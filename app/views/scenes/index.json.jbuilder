json.array!(@scenes) do |scene|
  json.extract! scene, :id, :title, :id_remote, :user_id
  json.url scene_url(scene, format: :json)
end
