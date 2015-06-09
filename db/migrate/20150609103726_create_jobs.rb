class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :id_remote
      t.integer :state, limit: 4, default: 0
      t.string :result_path
      t.references :scene

      t.timestamps null: false
    end
  end
end
