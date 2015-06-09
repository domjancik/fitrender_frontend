class Scene < ActiveRecord::Base
  belongs_to :user
  has_many :jobs

  validates :title, presence: true
  validates :user, presence: true

  def method_missing(name, *args)
    match = /^option_(\w+)$/.match name
    return get_option(match[1]) if match

    match = /^option_(\w+)=$/.match name
    return options[match[1]] = args[0]

    super
  end

  def renderer
    Renderer.find(renderer_id)
  end

  protected

  def get_option(name)
    return options[name] if options.has_key? name
    renderer.generator.option_value name
  end
end
