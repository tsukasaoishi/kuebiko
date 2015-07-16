require "kuebiko/version"
require "kuebiko/url"

module Kuebiko
  def self.default_components(options = {})
    Url.default_components(options)
  end
end
