module Rails
  module Generators
    class UrlGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_decorator_file
        template 'url.rb', File.join('app/urls', class_path, "#{file_name}_url.rb")
      end
    end
  end
end
