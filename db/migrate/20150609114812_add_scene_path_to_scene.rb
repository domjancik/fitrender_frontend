class AddScenePathToScene < ActiveRecord::Migration
  def change
    add_column :scenes, :scene_path, :string
  end
end
