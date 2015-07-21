require "kuebiko/url/components"
require "kuebiko/url/material"
require "kuebiko/preparation"

module Kuebiko
  class Url
    #def self.method_added(name)
    #end

    def initialize(*_, **options)
      @_options = options
    end

    private

    def build(*paths, **options)
      options[:trailing_slash] ||= my_trailing_slash
      Preparation.new(paths, options)
    end

    def options
      @_options
    end
  end
end
