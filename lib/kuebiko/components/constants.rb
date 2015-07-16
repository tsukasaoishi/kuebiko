module Kuebiko
  class Components
    CONFIGS = %i|scheme host port trailing_slash|
    DEFAULT = {scheme: :http, port: 80}
    private_constant :CONFIGS, :DEFAULT
  end
end
