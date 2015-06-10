class Job < ActiveRecord::Base
  include Adaptorable

  belongs_to :scene
  enum state: [ :other, :idle, :running, :completed, :failed ]
  validates :id_remote, presence: true

  has_attached_file :result, styles: {
                        thumb: '100x100>',
                        medium: '250x250>'
                           }
  validates_attachment_content_type :result, :content_type => /\Aimage\/.*\Z/

  def update_state
    # return if state == 'completed' || state == 'failed'
    job_info = get "jobs/#{id_remote}"
    self.state = job_info['state']

    # TODO copy result to public dir when state becomes completed
    return unless state == 'completed' && result.blank?
    self.result = File.open(result_path)
    self.save!
  end
end
