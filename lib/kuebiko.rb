require "kuebiko/version"
require "kuebiko/configuration"
require "kuebiko/url"

module Kuebiko
  def self.default_components(*args)
    Configuration.default_components(*args)
  end
end
