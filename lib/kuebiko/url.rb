require "kuebiko/url/components"
require "kuebiko/url/material"
require "kuebiko/preparation"

module Kuebiko
  class Url
    def self.method_added(name)
      return unless public_method_defined?(name)
      return if /_(path|url)\z/ === name

      class_eval <<-DEF_URL_METHOD, __FILE__, __LINE__ + 1
        class << self
          def #{name}_path(*args, **options)
            new(*args, **options).#{name}_path
          end

          def #{name}_url(*args, **options)
            new(*args, **options).#{name}_url
          end
        end

        def #{name}_path(options = {})
          "/" + #{name}.build
        end

        def #{name}_url(options = {})
          url = my_scheme.to_s + "://" + my_host.to_s
          url << (":" + my_port.to_s) if my_port
          url + "/" + #{name}.build
        end
      DEF_URL_METHOD
    end

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
