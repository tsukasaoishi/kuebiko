require 'test_helper'

class ComponentsTest < Minitest::Test
  def setup
    @klass = Class.new(Kuebiko::Url)
  end

  test "can specify schema" do
    _schema = :aaa
    @klass.class_eval { schema _schema }
    assert_equal _schema, @klass.components.schema
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
end
