require 'test_helper'

class GenerateUrlTest < Minitest::Test
  def setup
    @scheme = "http"
    @host = "#{SecureRandom.hex(10)}.com"
    @klass = Class.new(Kuebiko::Url) do
      def test
        build one, two, options
      end
    end
    @klass.host @host
    @klass.material :one, :two
  end

  def assert_generate_path(path, *args, **options)
    url = "#{@scheme}://#{@host}"
    url << ":#{@port}" if @port
    url << path
    assert_equal path, @url.test_path(options)
    assert_equal url, @url.test_url(options)
    assert_equal path, @klass.test_path(*args, **options)
    assert_equal url, @klass.test_url(*args, **options)
  end

  def multi_test(options)
    paths = %w|/test /test/tsu|
    paths.map!{|path| "#{path}/"} if options[:trailing_slash]
    @url = @klass.new(options)
    assert_generate_path "/", options
    @url = @klass.new("test", options)
    assert_generate_path paths[0], "test", options
    @url = @klass.new("test", "tsu", options)
    assert_generate_path paths[1], "test", "tsu", options

    yield

    @url = @klass.new
    assert_generate_path "/", options
    @url = @klass.new("test")
    assert_generate_path paths[0], "test", options
    @url = @klass.new("test", "tsu")
    assert_generate_path paths[1], "test", "tsu", options
  end

  test "no arguments returns root path(url)" do
    @url = @klass.new
    assert_generate_path "/"
  end

  test "material added" do
    @url = @klass.new("test")
    assert_generate_path "/test", "test"
    @url = @klass.new("test", "tsu")
    assert_generate_path "/test/tsu", "test", "tsu"
  end

  test "can specify trailing_slash" do
    multi_test(trailing_slash: true) do
      @klass.trailing_slash true
    end
  end

  test "can specify scheme" do
    @scheme = SecureRandom.hex(10)
    multi_test(scheme: @scheme) do
      @klass.scheme @scheme
    end
  end

  test "can specify host" do
    @host = "#{SecureRandom.hex(10)}.kaeruspoon.net"
    multi_test(host: @host) do
      @klass.host @host
    end
  end

  test "can specify port" do
    @port = rand(10000)
    multi_test(port: @port) do
      @klass.port @port
    end
  end

  test "can specify multi components" do
    @scheme = SecureRandom.hex(10)
    @host = "#{SecureRandom.hex(10)}.kaeruspoon.net"
    @port = rand(10000)
    multi_test(scheme: @scheme, host: @host, port: @port, trailing_slash: true) do
      @klass.scheme @scheme
      @klass.host @host
      @klass.port @port
      @klass.trailing_slash true
    end
  end
end
