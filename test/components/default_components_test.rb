require 'test_helper'

class DefaultComponentTest < Minitest::Test
  def teardown
    Kuebiko::Url.class_eval "@@components = {}"
  end

  def my(config)
    Kuebiko::Url.new.instance_eval "my_#{config}"
  end

  test "raise exception if unknown key is specified" do
    assert_raises(ArgumentError) {
      Kuebiko.default_components(hoge: true)
    }
  end

  test "can specify scheme" do
    scheme = :hoge
    Kuebiko.default_components(scheme: scheme)
    assert_equal scheme, my(:scheme)
  end

  test "can specify host" do
    host = "kaeruspoon.net"
    Kuebiko.default_components(host: host)
    assert_equal host, my(:host)
  end

  test "can specify port" do
    port = 443
    Kuebiko.default_components(port: port)
    assert_equal port, my(:port)
  end

  test "can specify trailing_slash" do
    Kuebiko.default_components(trailing_slash: true)
    assert my(:trailing_slash)
  end

  test "can specify more than one value" do
    scheme = :ftp
    host = "tsukasa.net"
    port = 3000
    Kuebiko.default_components(
      scheme: scheme, port: port, trailing_slash: true, host: host
    )

    assert_equal scheme, my(:scheme)
    assert_equal host, my(:host)
    assert_equal port, my(:port)
    assert my(:trailing_slash)
  end

  test "check default values" do
    assert_equal :http, my(:scheme)
    assert_nil my(:host)
    assert_nil my(:port)
    refute my(:trailing_slash)
  end
end
