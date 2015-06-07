require 'fitrender_common'

# Model representing a renderer.
# This model is backed by the Adaptor webservice instead of a DB.
# ActiveRecord style method naming is used to ensure some level of compatibility
class Renderer < Fitrender::Adaptor::Renderer
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include Modelable
  extend Adaptorable

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

  def to_s
    id
  end
end