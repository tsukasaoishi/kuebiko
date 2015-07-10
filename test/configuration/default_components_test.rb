require 'test_helper'

class DefaultComponentTest < Minitest::Test
  test "raise exception if unknown key is specified" do
    assert_raises(ArgumentError) {
      Kuebiko::Configuration.default_components(hoge: true)
    }
  end

  test "can specify schema" do
    schema = :hoge
    Kuebiko::Configuration.default_components(schema: schema)
    assert_equal schema, Kuebiko::Configuration.schema
  end

  test "can specify host" do
    host = "kaeruspoon.net"
    Kuebiko::Configuration.default_components(host: host)
    assert_equal host, Kuebiko::Configuration.host
  end

  test "can specify port" do
    port = 443
    Kuebiko::Configuration.default_components(port: port)
    assert_equal port, Kuebiko::Configuration.port
  end

  test "can specify trailing_slash" do
    Kuebiko::Configuration.default_components(trailing_slash: true)
    assert Kuebiko::Configuration.trailing_slash
  end

  test "can specify more than one value" do
    schema = :ftp
    host = "tsukasa.net"
    port = 3000
    Kuebiko::Configuration.default_components(
      schema: schema, port: port, trailing_slash: true, host: host
    )

    assert_equal schema, Kuebiko::Configuration.schema
    assert_equal host, Kuebiko::Configuration.host
    assert_equal port, Kuebiko::Configuration.port
    assert Kuebiko::Configuration.trailing_slash
  end

  test "check default values" do
    assert :http, Kuebiko::Configuration.schema
    assert_nil Kuebiko::Configuration.host
    assert 80, Kuebiko::Configuration.port
    refute Kuebiko::Configuration.trailing_slash
  end

  test "can use Kuebiko.default_components" do
    schema = :ftp
    host = "tsukasa.net"
    port = 3000
    Kuebiko.default_components(
      schema: schema, port: port, trailing_slash: true, host: host
    )

    assert_equal schema, Kuebiko::Configuration.schema
    assert_equal host, Kuebiko::Configuration.host
    assert_equal port, Kuebiko::Configuration.port
    assert Kuebiko::Configuration.trailing_slash
  end
end
