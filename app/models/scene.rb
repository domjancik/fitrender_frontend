require 'json'

class Scene < ActiveRecord::Base
  include Adaptorable

  belongs_to :user
  has_many :jobs

  validates :title, presence: true
  validates :user, presence: true
  validates :scene_path, presence: true

  def method_missing(name, *args)
    match = /^option_(\w+)$/.match name
    return get_option(match[1]) if match

    match = /^option_(\w+)=$/.match name
    return options[match[1]] = args[0] if match

    super
  end

  def renderer
    Renderer.find(renderer_id)
  end

  def submit
    job_list = post 'submit', path: scene_path, renderer_id: renderer_id, options: JSON.dump(options)
    job_list.each do |job|
      jobs.build(id_remote: job['id'], result_path: job['path'])
    end
  end

  protected

  def get_option(name)
    return options[name] if options.has_key? name
    renderer.generator.option_value name
  end
end
