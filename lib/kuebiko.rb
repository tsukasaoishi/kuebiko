require "kuebiko/version"
require "kuebiko/components"
require "kuebiko/url"

module Kuebiko
  def self.default_components(*args)
    Components.default_components(*args)
  end
end
