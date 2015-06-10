class Job < ActiveRecord::Base
  include Adaptorable

  belongs_to :scene
  enum state: [ :other, :idle, :running, :completed, :failed ]
  validates :id_remote, presence: true

  def update_state

  end
end
