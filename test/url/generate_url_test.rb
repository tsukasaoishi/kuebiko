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
    assert_equal path, @url.test_path(options)
    assert_equal "#{@scheme}://#{@host}#{path}", @url.test_url(options)
    assert_equal path, @klass.test_path(*args, **options)
    assert_equal "#{@scheme}://#{@host}#{path}", @klass.test_url(*args, **options)
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
    options = { trailing_slash: true }
    @url = @klass.new(options)
    assert_generate_path "/", options
    @url = @klass.new("test", options)
    assert_generate_path "/test/", "test", options
    @url = @klass.new("test", "tsu", options)
    assert_generate_path "/test/tsu/", "test", "tsu", options

    @klass.trailing_slash true
    @url = @klass.new
    assert_generate_path "/", options
    @url = @klass.new("test")
    assert_generate_path "/test/", "test", options
    @url = @klass.new("test", "tsu")
    assert_generate_path "/test/tsu/", "test", "tsu", options
  end

  test "can specify scheme" do
    @scheme = "tsuka"
    options = { scheme: @scheme }
    @url = @klass.new(options)
    assert_generate_path "/", options
    @url = @klass.new("test", options)
    assert_generate_path "/test", "test", options
    @url = @klass.new("test", "tsu", options)
    assert_generate_path "/test/tsu", "test", "tsu", options

    @klass.scheme @scheme
    @url = @klass.new
    assert_generate_path "/", options
    @url = @klass.new("test")
    assert_generate_path "/test", "test", options
    @url = @klass.new("test", "tsu")
    assert_generate_path "/test/tsu", "test", "tsu", options
  end
end
