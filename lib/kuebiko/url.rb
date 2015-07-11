require "kuebiko/components"

module Kuebiko
  class Url
    extend Components::ForUrl

    class << self
      private

      def schema_value
        if components.schema?
          components.schema
        else
          Kuebiko::Components.schema
        end
      end
    end
  end
end
