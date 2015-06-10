class AddAttachmentResultToJobs < ActiveRecord::Migration
  def self.up
    change_table :jobs do |t|
      t.attachment :result
    end
  end

  def self.down
    remove_attachment :jobs, :result
  end
end
