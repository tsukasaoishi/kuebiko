require "kuebiko/components"

module Kuebiko
  class Url
    class << self
      def schema(schema)
        components.schema = schema
      end

      def host(host)
        components.host = host
      end

      def port(port)
        components.port = port
      end

      def trailing_slash(trailing_slash)
        components.trailing_slash = trailing_slash
      end

      def components
        @components ||= Components.new
      end
    end
  end
end
