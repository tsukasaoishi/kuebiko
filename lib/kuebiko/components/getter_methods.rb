module Kuebiko
  class Components
    module GetterMethods
      CONFIGS.each do |config|
        class_eval <<-DEF_GETTER_CONFIG, __FILE__, __LINE__ + 1
          def #{config}
            components.#{config}
          end
        DEF_GETTER_CONFIG
      end

      def components
        @components ||= ::Kuebiko::Components.new
      end
    end
  end
end

