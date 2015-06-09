class RemoveIdRemoteFromScenesFix < ActiveRecord::Migration
  def change
    remove_column :scenes, :id_remote, :string
  end
end
