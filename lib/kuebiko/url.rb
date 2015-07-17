require 'cgi'
require "active_support/core_ext/object/to_query"
require "active_support/core_ext/object/blank"
require "kuebiko/url/components"
require "kuebiko/url/material"

module Kuebiko
  class Url
    def initialize(*_, **options)
      @_options = options
    end

    private

    def build(*args, query: nil, anchor: nil, trailing_slash: false)
      path = args.map{|a| CGI.escape(a.to_s)}.join('/')
      path << "/" if path.present? && (trailing_slash || my_trailing_slash)
      path << "?#{query.to_query}" if query.present?
      path << "##{CGI.escape(anchor.to_s)}" if anchor.present?
      path
    end

    def options
      @_options
    end
  end
end
