require 'test_helper'

class KlassComponentsTest < Minitest::Test
  def setup
    @klass = Class.new(Kuebiko::Url)
  end

  def teardown
    Kuebiko::Url.class_eval "@@components = {}"
  end

  def my(config)
    @url ||= @klass.new
    @url.instance_eval "my_#{config}"
  end

  test "can specify scheme" do
    _scheme = :aaa
    @klass.class_eval { scheme _scheme }
    assert_equal _scheme, my(:scheme)
  end

  test "can specify host" do
    _host = "kaeruspoon.net"
    @klass.class_eval { host _host }
    assert_equal _host, my(:host)
  end

  test "can specify port" do
    _port = 1999
    @klass.class_eval { port _port }
    assert_equal _port, my(:port)
  end

  test "can specify trailing_slash" do
    @klass.class_eval { trailing_slash true }
    assert my(:trailing_slash)
  end

  test "can specify more than one value" do
    _scheme = :bbb
    _host = "a.kaeruspoon.net"
    _port = 2015

    @klass.class_eval do
      scheme _scheme
      host _host
      port _port
      trailing_slash true
    end

    assert_equal _scheme, my(:scheme)
    assert_equal _host, my(:host)
    assert_equal _port, my(:port)
    assert my(:trailing_slash)
  end

  test "use value of Kuebiko.default_components if you don't specify" do
    _scheme = :ccc
    _host = "b.kaeruspoon.net"
    _port = 1977
    Kuebiko.default_components(scheme: _scheme, host: _host, port: _port, trailing_slash: true)

    assert_equal _scheme, my(:scheme)
    assert_equal _host, my(:host)
    assert_equal _port, my(:port)
    assert my(:trailing_slash)
  end

  test "override value of Kuebiko.default_components if you specify" do
    _scheme = :ddd
    _host = "c.kaeruspoon.net"
    _port = 1976
    Kuebiko.default_components(scheme: :eee, host: "d.kaeruspoon.net", port: 1975, trailing_slash: true)

    @klass.class_eval do
      scheme _scheme
      host _host
      port _port
      trailing_slash false
    end

    assert_equal _scheme, my(:scheme)
    assert_equal _host, my(:host)
    assert_equal _port, my(:port)
    refute my(:trailing_slash)
  end
end
