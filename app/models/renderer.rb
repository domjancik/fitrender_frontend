require 'fitrender_common'

# Model representing a renderer.
# This model is backed by the Adaptor webservice instead of a DB.
# ActiveRecord style method naming is used to ensure some level of compatibility
class Renderer < Fitrender::Adaptor::Renderer
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include Modelable
  extend Adaptorable

  # TODO join code with Scene or move functionality to Configurable
  def method_missing(name, *args)
    match = /^option_(\w+)$/.match name
    return option_value(match[1]) if match

    match = /^option_(\w+)=$/.match name
    return option_set_value(match[1], args[0]) if match

    super
  end

  def self.all
    renderers = []

    nodes_hash = get('renderers')
    nodes_hash.each do |node_hash|
      renderers << from_hash(node_hash)
    end

    renderers
  end

  def self.find(id)
    from_hash get("renderers/#{id}")
  end

  def name
    self.id
  end

  def self.valid(id)
    return false unless id
    begin
      self.find id
      true
    rescue
      false
    end
  end

  def update(*args)
    puts args.class
    args.each do |arg|
      arg.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    self.save
  end

  def save
    params = {}
    options_list.each do |option|
      params[option.id] = option.value
    end

    puts params

    Renderer.patch "renderers/#{id}", params
  end

  def to_s
    id
  end

  def to_key
    return *self.id
  end
end