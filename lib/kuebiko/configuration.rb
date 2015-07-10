module Kuebiko
  class Configuration
    class << self
      attr_reader :schema, :host, :port, :trailing_slash

      def default_components(schema: :http, host: nil, port: 80, trailing_slash: false)
        @schema = schema
        @host = host
        @port = port
        @trailing_slash = trailing_slash
      end
    end
  end
end
