require "kuebiko/version"
require "kuebiko/url"
require "kuebiko/railtie" if defined?(Rails)

module Kuebiko
  def self.default_components(options = {})
    Url.default_components(options)
  end
end
