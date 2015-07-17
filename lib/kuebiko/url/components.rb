module Kuebiko
  class Url
    DEFAULT = {scheme: :http, port: 80}
    COMPONENTS = %i|scheme host port trailing_slash|
    private_constant :DEFAULT, :COMPONENTS

    @@components = {}

    class << self
      def default_components(options = {})
        options.each do |comp, value|
          raise ArgumentError, "unknown components #{comp.inspect}" unless COMPONENTS.include?(comp)
          instance_eval "#{comp}(value)"
        end
      end
    end


    COMPONENTS.each do |config|
      class_eval <<-DEF_COMP, __FILE__, __LINE__ + 1
        class << self
          def #{config}(value)
            @@components[self] ||= {}
            @@components[self][:#{config}] = value
          end
        end

        def my_#{config}(klass = self.class)
          my_components = (@@components[klass] ||= {})
          if my_components.key?(:#{config})
            my_components[:#{config}]
          elsif klass == ::Kuebiko::Url
            DEFAULT[:#{config}]
          else
            my_#{config}(self.class.superclass)
          end
        end
        private :my_#{config}
      DEF_COMP
    end
  end
end