require "kuebiko/components"
require 'cgi'
require "active_support/core_ext/object/to_query"
require "active_support/core_ext/object/blank"

module Kuebiko
  class Url
    extend Components::ForUrl

    class << self
      def resource(*names)
        class_eval <<-DEF_INIT, __FILE__, __LINE__ + 1
          def initialize(*resources, **options)
            #{names.map{|n| "@_#{n}"}.join(", ")}, _dust = resources
            @_options = options
          end

          #{names.map{|n| "def #{n}; @_#{n}; end"}.join("\n")}
          private #{names.map{|n| ":#{n}"}.join(", ")}
        DEF_INIT
      end
    end

    def initialize(*resources, **options)
      @_options = options
    end

    private

    def build(*args, query: nil, anchor: nil)
      path = args.map{|a| CGI.escape(a.to_s)}.join('/')
      path << "?#{query.to_query}" if query.present?
      path << "##{CGI.escape(anchor.to_s)}" if anchor.present?
      path
    end

    def options
      @_options
    end
  end
end
