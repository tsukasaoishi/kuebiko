module Kuebiko
  class Components
    CONFIGS = %i|schema host port trailing_slash|
    DEFAULT = {schema: :http, port: 80}
    private_constant :CONFIGS, :DEFAULT
  end
end
