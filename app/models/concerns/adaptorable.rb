require 'rest-client'

# TODO come up with a better name
# Adds get, post, ... methods that directly communicate with the Fitrender Adaptor
module Adaptorable
  def get(resource)
    begin
      response = RestClient.get "#{Rails.application.secrets.fitrender_adaptor_url}/#{resource}"
      JSON.parse(response.to_str)
    rescue RestClient::ResourceNotFound
      raise ActiveRecord::RecordNotFound
    end
  end
end