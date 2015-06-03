require 'rest-client'
require 'fitrender_common'

# Model representing a node.
# This model is backed by the Adaptor webservice instead of a DB.
# ActiveRecord style method naming is used to ensure some level of compatibility
class Node < Fitrender::Adaptor::Node
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def self.all
    nodes = []

    nodes_hash = get_from_adaptor('nodes')
    nodes_hash.each do |node_hash|
      nodes << from_hash(node_hash)
    end

    nodes
  end

  def self.find(id)
    from_hash get_from_adaptor("node/#{id}")
  end

  def to_s
    id
  end

  def to_model
    self
  end

  def persisted?
    true
  end

  private

  def self.get_from_adaptor(resource)
    response = RestClient.get "#{Rails.application.secrets.fitrender_adaptor_url}/#{resource}"
    JSON.parse(response.to_str)
  end
end