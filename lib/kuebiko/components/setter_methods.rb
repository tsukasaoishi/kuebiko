module Kuebiko
  class Components
    module SetterMethods
      CONFIGS.each do |config|
        class_eval <<-DEF_SETTER_CONFIG, __FILE__, __LINE__ + 1
          def #{config}(value)
            components.#{config} = value
          end
        DEF_SETTER_CONFIG
      end

      def components
        @components ||= ::Kuebiko::Components.new
      end
    end
  end
end
