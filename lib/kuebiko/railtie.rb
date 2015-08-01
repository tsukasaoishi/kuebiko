module Kuebiko
  class Railtie < Rails::Railtie
    initializer "kuebiko.autoload", before: :set_autoload_paths do |app|
      app.config.autoload_paths << "#{app.config.root}/app/urls"
    end
  end
end
