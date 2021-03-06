module Kuebiko
  class Url
    class << self
      def material(*names)
        class_eval <<-DEF_INIT, __FILE__, __LINE__ + 1
          def initialize(*materials, **options)
            #{names.map{|n| "@_#{n}"}.join(", ")}, _dust = materials
            @_options = options
          end

          #{names.map{|n| "def #{n}; @_#{n}; end"}.join("\n")}
          private #{names.map{|n| ":#{n}"}.join(", ")}
        DEF_INIT
      end
    end
  end
end

