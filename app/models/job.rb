class Job < ActiveRecord::Base
  include Adaptorable

  default_scope -> { order(:id_remote) }

  belongs_to :scene
  enum state: [ :other, :idle, :running, :completed, :failed ]
  validates :id_remote, presence: true

  has_attached_file :result, styles: {
                        thumb: '100x100>',
                        medium: '250x250>'
                           }
  validates_attachment_content_type :result, :content_type => /\Aimage\/.*\Z/

  def update_state
    return if state == 'completed' || state == 'failed'
    begin
      job_info = get "jobs/#{id_remote}"
    rescue RestClient::InternalServerError
      return
    end

    self.state = job_info['state']

    # TODO copy result to public dir when state becomes completed
    return unless state == 'completed'
    begin
      self.result = File.open(result_path)
    rescue Errno::EIO
      # Result file is currently inaccessible, possibly due to being saved
      self.state = 'other'
    rescue Errno::ENOENT
      # No such file, something failed
      self.state = 'failed'
    end
    self.save!
  end
end
