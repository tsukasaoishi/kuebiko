require 'test_helper'

class ComponentsTest < Minitest::Test
  def setup
    @klass = Class.new(Kuebiko::Url)
  end

  def teardown
    Kuebiko::Components.class_eval do
      @components = nil
    end
  end

  test "can specify scheme" do
    _scheme = :aaa
    @klass.class_eval { scheme _scheme }
    assert_equal _scheme, @klass.components.scheme
  end

  test "can specify host" do
    _host = "tsukasa.com"
    @klass.class_eval { host _host }
    assert_equal _host, @klass.components.host
  end

  test "can specify port" do
    _port = 1999
    @klass.class_eval { port _port }
    assert_equal _port, @klass.components.port
  end

  test "can specify trailing_slash" do
    @klass.class_eval { trailing_slash true }
    assert @klass.components.trailing_slash
  end

  test "can specify more than one value" do
    _scheme = :bbb
    _host = "oishi.com"
    _port = 2015

    @klass.class_eval do
      scheme _scheme
      host _host
      port _port
      trailing_slash true
    end

    assert_equal _scheme, @klass.components.scheme
    assert_equal _host, @klass.components.host
    assert_equal _port, @klass.components.port
    assert @klass.components.trailing_slash
  end

  test "use value of Kuebiko.default_components if you don't specify" do
    _scheme = :ccc
    _host = "tsutsu.com"
    _port = 1977
    Kuebiko.default_components(scheme: _scheme, host: _host, port: _port, trailing_slash: true)

    assert_equal _scheme, @klass.class_eval{ scheme_value }
    assert_equal _host, @klass.class_eval{ host_value }
    assert_equal _port, @klass.class_eval{ port_value }
    assert @klass.class_eval{ trailing_slash_value }
  end

  test "override value of Kuebiko.default_components if you specify" do
    _scheme = :ddd
    _host = "tsutsutsu.com"
    _port = 1976
    Kuebiko.default_components(scheme: :eee, host: "hoge.com", port: 1975, trailing_slash: true)

    @klass.class_eval do
      scheme _scheme
      host _host
      port _port
      trailing_slash false
    end

    assert_equal _scheme, @klass.class_eval{ scheme_value }
    assert_equal _host, @klass.class_eval{ host_value }
    assert_equal _port, @klass.class_eval{ port_value }
    refute @klass.class_eval{ trailing_slash_value }
  end
end
