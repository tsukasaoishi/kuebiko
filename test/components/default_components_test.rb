require 'test_helper'

class DefaultComponentTest < Minitest::Test
  def setup
    Kuebiko::Components.class_eval do
      @components = nil
    end
  end

  test "raise exception if unknown key is specified" do
    assert_raises(ArgumentError) {
      Kuebiko::Components.default_components(hoge: true)
    }
  end

  test "can specify schema" do
    schema = :hoge
    Kuebiko::Components.default_components(schema: schema)
    assert_equal schema, Kuebiko::Components.schema
  end

  test "can specify host" do
    host = "kaeruspoon.net"
    Kuebiko::Components.default_components(host: host)
    assert_equal host, Kuebiko::Components.host
  end

  test "can specify port" do
    port = 443
    Kuebiko::Components.default_components(port: port)
    assert_equal port, Kuebiko::Components.port
  end

  test "can specify trailing_slash" do
    Kuebiko::Components.default_components(trailing_slash: true)
    assert Kuebiko::Components.trailing_slash
  end

  test "can specify more than one value" do
    schema = :ftp
    host = "tsukasa.net"
    port = 3000
    Kuebiko::Components.default_components(
      schema: schema, port: port, trailing_slash: true, host: host
    )

    assert_equal schema, Kuebiko::Components.schema
    assert_equal host, Kuebiko::Components.host
    assert_equal port, Kuebiko::Components.port
    assert Kuebiko::Components.trailing_slash
  end

  test "check default values" do
    assert_equal :http, Kuebiko::Components.schema
    assert_nil Kuebiko::Components.host
    assert_equal 80, Kuebiko::Components.port
    refute Kuebiko::Components.trailing_slash
  end

  test "can use Kuebiko.default_components" do
    schema = :ftp
    host = "tsukasa.net"
    port = 3000
    Kuebiko.default_components(
      schema: schema, port: port, trailing_slash: true, host: host
    )

    assert_equal schema, Kuebiko::Components.schema
    assert_equal host, Kuebiko::Components.host
    assert_equal port, Kuebiko::Components.port
    assert Kuebiko::Components.trailing_slash
  end
end
