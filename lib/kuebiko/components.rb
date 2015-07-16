require "kuebiko/components/constants"
require "kuebiko/components/getter_methods"
require "kuebiko/components/for_url"

module Kuebiko
  class Components
    extend GetterMethods

    class << self
      def default_components(*args)
        comp = new
        comp.setup(*args)
        @components = comp
      end
    end

    def setup(options = {})
      bad_keys = options.keys - CONFIGS
      raise ArgumentError unless bad_keys.empty?

      CONFIGS.each do |config|
        instance_variable_set("@#{config}", options[config]) unless options[config].nil?
      end
    end

    CONFIGS.each do |config|
      class_eval <<-DEF_CONFIG, __FILE__, __LINE__ + 1
        def #{config}?
          instance_variable_defined?(:@#{config})
        end

        def #{config}
          #{config}? ? @#{config} : DEFAULT[:#{config}]
        end

        def #{config}=(value)
          @#{config} = value
        end
      DEF_CONFIG
    end
  end
end

