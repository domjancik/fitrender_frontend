class AddRendererIdToScene < ActiveRecord::Migration
  def change
    add_column :scenes, :renderer_id, :string
  end
end
