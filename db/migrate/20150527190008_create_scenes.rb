class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.string :title
      t.string :id_remote
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
