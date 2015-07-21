require 'cgi'
require "active_support/core_ext/object/to_query"
require "active_support/core_ext/object/blank"

module Kuebiko
  class Preparation
    attr_reader :scheme, :host, :port

    def initialize(paths, options)
      @paths = paths
      @query = options[:query]
      @anchor = options[:anchor]
      @trailing_slash = options[:trailing_slash]
      @scheme = options[:scheme]
      @host = options[:host]
      @port = options[:port]
    end

    def build
      path = @paths.map{|a| CGI.escape(a.to_s)}.join('/')
      path << "/" if path.present? && @trailing_slash
      path << "?#{@query.to_query}" if @query.present?
      path << "##{CGI.escape(@anchor.to_s)}" if @anchor.present?
      path
    end
  end
end
