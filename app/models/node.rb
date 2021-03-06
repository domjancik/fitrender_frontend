require 'fitrender_common'

# Model representing a node.
# This model is backed by the Adaptor webservice instead of a DB.
# ActiveRecord style method naming is used to ensure some level of compatibility
class Node < Fitrender::Adaptor::Node
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include Modelable
  extend Adaptorable

  def self.all
    nodes = []

    nodes_hash = get('nodes')
    nodes_hash.each do |node_hash|
      nodes << from_hash(node_hash)
    end

    nodes
  end

  def self.find(id)
    from_hash get("nodes/#{id}")
  end
end