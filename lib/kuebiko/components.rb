module Kuebiko
  class Components
    class << self
      def default_components(*args)
        @components = new(*args)
      end

      def schema
        components.schema
      end

      def host
        components.host
      end

      def port
        components.port
      end

      def trailing_slash
        components.trailing_slash
      end

      private

      def components
        @components ||= new
      end
    end

    SCHEMA = :http
    PORT = 80
    private_constant :SCHEMA, :PORT

    attr_writer :schema, :port
    attr_accessor :host, :trailing_slash

    def initialize(schema: SCHEMA, host: nil, port: PORT, trailing_slash: false)
      @schema = schema
      @host = host
      @port = port
      @trailing_slash = trailing_slash
    end

    def schema
      @schema || SCHEMA
    end

    def port
      @port || PORT
    end
  end
end
