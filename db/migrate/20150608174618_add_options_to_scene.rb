class AddOptionsToScene < ActiveRecord::Migration
  def change
    add_column :scenes, :options, :json
    execute "ALTER TABLE scenes ALTER COLUMN options SET DEFAULT '{}'::JSON"
  end
end
